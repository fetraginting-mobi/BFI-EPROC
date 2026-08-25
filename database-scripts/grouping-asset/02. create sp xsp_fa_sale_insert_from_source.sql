CREATE PROCEDURE [dbo].[xsp_fa_sale_insert_from_source]  
(  
    @p_barcode          NVARCHAR(20),  
    @p_fa_sale_code     NVARCHAR(15),  
    @p_cre_date         DATETIME,  
    @p_cre_by           NVARCHAR(15),  
    @p_cre_ip_address   NVARCHAR(15),  
    @p_mod_date         DATETIME,  
    @p_mod_by           NVARCHAR(15),  
    @p_mod_ip_address   NVARCHAR(15)  
)  
AS  
BEGIN  
  
    DECLARE   
        @code_asset             NVARCHAR(18),  
        @name_asset             NVARCHAR(60),  
        @description            NVARCHAR(2000),  
        @orig_price             DECIMAL(18,2),  
        @tot_depre              DECIMAL(18,2),  
        @net_book_value         DECIMAL(18,2),  
        @fa_asset_id            INT,  
        @barcode_valid          INT,  
        @fa_group_asset_code    NVARCHAR(20)  
  
    SELECT    
        @fa_asset_id       = ID,  
        @code_asset        = AST_CODE,  
        @name_asset        = AST_NAME,  
        @description       = REMARKS,  
        @orig_price        = ORIG_PRICE,  
        @tot_depre         = TOT_DEPRE,  
        @net_book_value    = NET_BOOK_VALUE  
    FROM FA_ASSET  
    WHERE BARCODE = @p_barcode  
  
  
    IF EXISTS  
    (  
        SELECT 1  
        FROM FA_SALE_DETAIL  
        WHERE FA_SALE_CODE = @p_fa_sale_code  
          AND BARCODE = @p_barcode  
    )  
    BEGIN  
        RAISERROR('barcode sudah ada',16,1)  
        RETURN  
    END  
  
    SELECT @fa_group_asset_code = FA_GA_CODE  
    FROM FA_GROUPING_ASSET_DETAIL  
    WHERE BARCODE = @p_barcode  
      AND IS_PARENT = 1  
      AND IS_ACTIVE = 1  
  
  
    IF @fa_group_asset_code IS NOT NULL  
    BEGIN  
  
        DECLARE   
            @loop_asset_id INT,  
            @loop_code_asset NVARCHAR(18),  
            @loop_name_asset NVARCHAR(60),  
            @loop_description NVARCHAR(2000),  
            @loop_orig_price DECIMAL(18,2),  
            @loop_tot_depre DECIMAL(18,2),  
            @loop_net_book_value DECIMAL(18,2),  
            @loop_barcode NVARCHAR(20)  
  
        DECLARE asset_cursor CURSOR FOR  
        SELECT   
            a.ID,  
            a.AST_CODE,  
            a.AST_NAME,  
            a.REMARKS,  
            a.ORIG_PRICE,  
            a.TOT_DEPRE,  
            a.NET_BOOK_VALUE,  
            a.BARCODE  
        FROM FA_GROUPING_ASSET_DETAIL d  
        INNER JOIN FA_ASSET a  
            ON d.FA_ASSET_ID = a.ID  
        WHERE d.FA_GA_CODE = @fa_group_asset_code  
          AND d.IS_ACTIVE = 1 and a.TRANS_FLAG_CODE ='AVAILABLE'  
  
        OPEN asset_cursor  
  
        FETCH NEXT FROM asset_cursor INTO  
            @loop_asset_id,  
            @loop_code_asset,  
            @loop_name_asset,  
            @loop_description,  
            @loop_orig_price,  
            @loop_tot_depre,  
            @loop_net_book_value,  
            @loop_barcode  
  
        WHILE @@FETCH_STATUS = 0  
        BEGIN  
  
            IF NOT EXISTS  
            (  
                SELECT 1  
                FROM FA_SALE_DETAIL  
                WHERE FA_SALE_CODE = @p_fa_sale_code  
                  AND BARCODE = @loop_barcode  
            )  
            BEGIN  
                EXEC dbo.xsp_fa_sale_detail_insert  
                    0,  
                    @p_fa_sale_code,  
                    @loop_asset_id,  
                    @loop_code_asset,  
                    @loop_name_asset,  
                    @loop_barcode,  
                    @loop_description,  
                    0,  
                    @loop_orig_price,  
                    @loop_tot_depre,  
                    @loop_net_book_value,  
                    @p_cre_date,  
                    @p_cre_by,  
                    @p_cre_ip_address,  
                    @p_mod_date,  
                    @p_mod_by,  
                    @p_mod_ip_address  
            END  
  
            FETCH NEXT FROM asset_cursor INTO  
                @loop_asset_id,  
                @loop_code_asset,  
                @loop_name_asset,  
                @loop_description,  
                @loop_orig_price,  
                @loop_tot_depre,  
                @loop_net_book_value,  
                @loop_barcode  
        END  
  
        CLOSE asset_cursor  
        DEALLOCATE asset_cursor  
  
    END  
    ELSE  
    BEGIN  
  
        ------------------------------------------------  
        -- NON PARENT → INSERT SINGLE  
        ------------------------------------------------  
        EXEC dbo.xsp_fa_sale_detail_insert  
            0,  
            @p_fa_sale_code,  
            @fa_asset_id,  
            @code_asset,  
            @name_asset,  
            @p_barcode,  
            @description,  
            0,  
            @orig_price,  
            @tot_depre,  
            @net_book_value,  
            @p_cre_date,  
            @p_cre_by,  
            @p_cre_ip_address,  
            @p_mod_date,  
            @p_mod_by,  
            @p_mod_ip_address  
  
    END  
  
END