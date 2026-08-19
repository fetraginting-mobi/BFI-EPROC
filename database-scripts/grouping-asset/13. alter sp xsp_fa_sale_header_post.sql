ALTER PROCEDURE [dbo].[xsp_fa_sale_header_post]
(
    @p_code_barcode             nvarchar(14),
    @p_mod_by                   nvarchar(15),
    @p_mod_date                 datetime,
    @p_mod_ip_address           nvarchar(15)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ast_code                   nvarchar(18),
            @asset_code                 nvarchar(18),
            @trans_flag_code            nvarchar(10),
            @from_location_code         nvarchar(50),
            @pic                        nvarchar(15),
            @sale_date                  datetime,
            @fa_asset_id                int,
            @sale_value                 decimal(18,2),
            @code_barcode               nvarchar(18),
            @date                       datetime,
            @barcode                    nvarchar(14),
            @count                      int,
            @orig_price                 decimal(18,2),
            @total_depresiasi           decimal(18,2),
            @tot_net_book_value         decimal(18,2),
            @tot_orig_amount            decimal(18,2),
            @net_book_value             decimal(18,2),
            @fa_category_id             int,
            @is_use_operating_leasee    nvarchar(1),
            @cat_code                   nvarchar(10),
            @branch_code                nvarchar(20),
            @to_bank                    nvarchar(20),
            @bank_account_no            nvarchar(20),
            @bank_account_name          nvarchar(20),
            @rr_no                      nvarchar(50),
            @count_date                 int,
            @dc_barcode                 nvarchar(20),
            @fa_asset_no                nvarchar(50),
            @jurnalid                   nvarchar(20),
            @datapaymentid              nvarchar(4),
            @object_info                nvarchar(20),
            @status_asset               nvarchar(20),
            @branch_description         nvarchar(50);

    SELECT @count = COUNT(id)
    FROM dbo.fa_sale_detail
    WHERE fa_sale_code = @p_code_barcode;

    IF @count = 0
    BEGIN
        RAISERROR ('Data Sale detail belum diisi', 16, 1);
        RETURN;
    END;

    EXEC dbo.xsp_fa_sale_header_post_validate
         @p_code_barcode = @p_code_barcode,
         @p_mod_by = @p_mod_by,
         @p_mod_date = @p_mod_date,
         @p_mod_ip_address = @p_mod_ip_address;

    DECLARE date_cursor CURSOR FAST_FORWARD LOCAL FOR
    SELECT COUNT(fa.barcode),
           fa.barcode
    FROM dbo.fa_asset fa
    INNER JOIN dbo.fa_sale_detail fad
        ON fa.barcode = fad.barcode
    INNER JOIN dbo.fa_sale_header fah
        ON fad.fa_sale_code = fah.code_barcode
    WHERE date_purc <= fah.sale_date
      AND fah.code_barcode = @p_code_barcode
    GROUP BY fa.barcode;

    OPEN date_cursor;
    FETCH date_cursor INTO @count_date, @dc_barcode;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @count_date = 0
        BEGIN
            CLOSE date_cursor;
            DEALLOCATE date_cursor;
            RAISERROR ('assets are not yet available on that date', 16, 1);
            RETURN;
        END;

        FETCH date_cursor INTO @count_date, @dc_barcode;
    END;

    CLOSE date_cursor;
    DEALLOCATE date_cursor;

    DECLARE c_fa_asset_history_location CURSOR FOR
    SELECT fsd.barcode,
           fa.current_branch,
           fsh.sale_date,
           fsh.code_barcode,
           fsh.cre_by,
           fsd.sale_value,
           fsd.fa_asset_id,
           fa.cat_code,
           fa.branch_code,
           sbb.bank_account_no,
           sbb.bank_account_name,
           sbb.bank_name
    FROM dbo.fa_sale_header fsh
    LEFT JOIN dbo.fa_sale_detail fsd
        ON fsd.fa_sale_code = fsh.code_barcode
    LEFT JOIN dbo.fa_asset fa
        ON fa.barcode = fsd.barcode
    LEFT JOIN dbo.fa_category fc
        ON fc.cat_code = fa.cat_code
    LEFT JOIN dbo.sys_branch_bank sbb
        ON sbb.branch_code = fa.branch_code
    WHERE fa_sale_code = @p_code_barcode;

    OPEN c_fa_asset_history_location;
    FETCH c_fa_asset_history_location
    INTO @barcode,
         @from_location_code,
         @sale_date,
         @code_barcode,
         @pic,
         @sale_value,
         @fa_asset_id,
         @cat_code,
         @branch_code,
         @bank_account_no,
         @bank_account_name,
         @to_bank;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @sale_value = 0.00
        BEGIN
            CLOSE c_fa_asset_history_location;
            DEALLOCATE c_fa_asset_history_location;
            RAISERROR ('sale valu must be grether then 0!', 16, 1);
            RETURN;
        END;

        IF @sale_value < 0.00
        BEGIN
            CLOSE c_fa_asset_history_location;
            DEALLOCATE c_fa_asset_history_location;
            RAISERROR ('Sale value is smaller than 0!', 16, 1);
            RETURN;
        END;

        UPDATE dbo.fa_asset
        SET trans_flag_code = UPPER('SOLD INPROGRESS'),
            mod_date = @p_mod_date,
            mod_by = @p_mod_by,
            mod_ip_address = @p_mod_ip_address
        WHERE barcode = @barcode;

        SELECT @branch_description = description
        FROM dbo.master_branch
        WHERE code = @branch_code;

        IF EXISTS
        (
            SELECT 1
            FROM dbo.api_fa
            WHERE asset_code = @barcode
        )
        BEGIN
            UPDATE dbo.api_fa
            SET branchid = @branch_code,
                costumer_name = @branch_description,
                mod_by = @p_mod_by,
                mod_date = @p_mod_date,
                mod_ip_address = @p_mod_ip_address
            WHERE asset_code = @barcode;
        END
        ELSE
        BEGIN
            SET @status_asset = UPPER('SOLD INPROGRESS');

            IF EXISTS
            (
                SELECT 1
                FROM dbo.fa_asset
                WHERE barcode = @barcode
                  AND asset_type = 'VHCL'
                  AND current_branch <> 'COP'
            )
            BEGIN
                EXEC dbo.xsp_api_fix_asset_insert
                     @branch_code,
                     @barcode,
                     '',
                     @object_info,
                     '',
                     '',
                     '',
                     '',
                     '',
                     @branch_description,
                     @status_asset,
                     @p_mod_date,
                     @p_mod_by,
                     @p_mod_ip_address,
                     'UNPOST',
                     '';
            END;
        END;

        FETCH c_fa_asset_history_location
        INTO @barcode,
             @from_location_code,
             @sale_date,
             @code_barcode,
             @pic,
             @sale_value,
             @fa_asset_id,
             @cat_code,
             @branch_code,
             @bank_account_no,
             @bank_account_name,
             @to_bank;
    END;

    CLOSE c_fa_asset_history_location;
    DEALLOCATE c_fa_asset_history_location;

    SET @jurnalid = dbo.fn_get_next_fa_sale_jurnal_id(@sale_date, @branch_code);
    SET @datapaymentid = RIGHT(@jurnalid, 4);

    UPDATE dbo.fa_sale_header
    SET trans_flag_code = 'POST',
        mod_by = @p_mod_by,
        mod_date = @p_mod_date,
        mod_ip_address = @p_mod_ip_address,
        jurnal_id = @jurnalid,
        datapaymentid = @datapaymentid
    WHERE code_barcode = @p_code_barcode;
END;
