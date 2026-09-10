SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[xsp_fa_request_mutation_header_post]
    @p_code_barcode VARCHAR(50),
    @p_mod_by VARCHAR(50),
    @p_mod_date DATETIME,
    @p_mod_ip_address VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @v_flag_process VARCHAR(10)
           ,@count INT
           ,@mutation_code NVARCHAR(36);

    SELECT
        @v_flag_process = ISNULL(frmh.FLAG_PROCESS, ''),
        @mutation_code = frmh.CODE
    FROM dbo.FA_REQUEST_MUTATION_HEADER frmh
    WHERE frmh.CODE_BARCODE = @p_code_barcode;

    IF OBJECT_ID('tempdb..#all_error') IS NOT NULL DROP TABLE #all_error;
    CREATE TABLE #all_error
    (
        row_number INT,
        error_message VARCHAR(MAX)
    );

    BEGIN TRY
        SELECT @count = COUNT(id)
        FROM dbo.FA_REQUEST_MUTATION_DETAIL
        WHERE IR_CODE = @p_code_barcode;

        IF @v_flag_process <> 'UPL'
        BEGIN
            IF @count = 0
            BEGIN
                RAISERROR ('fa mutation detail must be inserted', 16, 1);
            END

            IF @count < 0
            BEGIN
                RAISERROR ('Quantity must be greater than 0!', 16, 1);
            END
        END
        ELSE
        BEGIN
            EXEC dbo.xsp_fa_request_mutation_header_post_upload_validate
                @p_code_barcode = @p_code_barcode;

            IF @count = 0
            BEGIN
                INSERT INTO #all_error (row_number, error_message)
                VALUES (1, 'fa mutation detail must be inserted');
            END

            IF @count < 0
            BEGIN
                INSERT INTO #all_error (row_number, error_message)
                VALUES (2, 'Quantity must be greater than 0!');
            END

            INSERT INTO #all_error (row_number, error_message)
            SELECT
                 ROW_NUMBER() OVER(ORDER BY farm.ID) + 2
                ,'asset sedang dalam proses sale (code_barcode: ' + fsh.CODE_BARCODE + ')'
            FROM dbo.FA_REQUEST_MUTATION_DETAIL farm
            JOIN dbo.FA_SALE_DETAIL fsd
                ON fsd.BARCODE COLLATE database_default = farm.ITEM_CODE
            JOIN dbo.FA_SALE_HEADER fsh
                ON fsh.CODE_BARCODE = fsd.FA_SALE_CODE
            WHERE farm.IR_CODE = @p_code_barcode
              AND fsh.TRANS_FLAG_CODE IN ('NEW', 'ONPROGRESS');

            INSERT INTO #all_error (row_number, error_message)
            SELECT
                 ROW_NUMBER() OVER(ORDER BY farm.ID) + 2
                ,'asset sedang dalam proses disposal (code_barcode: ' + fdh.CODE_BARCODE + ')'
            FROM dbo.FA_REQUEST_MUTATION_DETAIL farm
            JOIN dbo.FA_DISPOSAL_DETAIL fdd
                ON fdd.BARCODE COLLATE database_default = farm.ITEM_CODE
            JOIN dbo.FA_DISPOSAL_HEADER fdh
                ON fdh.CODE_BARCODE = fdd.FA_DISPOSAL_CODE
            WHERE farm.IR_CODE = @p_code_barcode
              AND fdh.TRANS_FLAG_CODE IN ('NEW', 'ONPROGRESS');

            INSERT INTO #all_error (row_number, error_message)
            SELECT
                 ROW_NUMBER() OVER(ORDER BY farm.ID) + 2
                ,'asset sedang dalam proses mutation (code_barcode: ' + farh.CODE_BARCODE + ')'
            FROM dbo.FA_REQUEST_MUTATION_DETAIL farm
            JOIN dbo.FA_REQUEST_MUTATION_DETAIL farm_other
                ON farm_other.ITEM_CODE COLLATE database_default = farm.ITEM_CODE
            JOIN dbo.FA_REQUEST_MUTATION_HEADER farh
                ON farh.CODE_BARCODE = farm_other.IR_CODE
            WHERE farm.IR_CODE = @p_code_barcode
              AND farh.CODE_BARCODE <> @p_code_barcode
              AND (farm_other.STATUS_RECEIVED IN ('SENT', 'RETURNED') OR farm_other.STATUS_RECEIVED IS NULL);

            IF EXISTS (SELECT 1 FROM #all_error)
            BEGIN
                RAISERROR('VALIDATION_FAILED', 16, 1);
            END
        END

        UPDATE dbo.FA_REQUEST_MUTATION_HEADER
        SET    TRANS_FLAG_CODE  = 'POST'
              ,MOD_BY           = @p_mod_by
              ,MOD_DATE         = @p_mod_date
              ,MOD_IP_ADDRESS   = @p_mod_ip_address
        WHERE  CODE_BARCODE     = @p_code_barcode;

        UPDATE dbo.FA_REQUEST_MUTATION_DETAIL
        SET    STATUS_RECEIVED  = 'SENT'
              ,MOD_BY           = @p_mod_by
              ,MOD_DATE         = @p_mod_date
              ,MOD_IP_ADDRESS   = @p_mod_ip_address
        WHERE  IR_CODE          = @p_code_barcode;

        DECLARE @ga_detail_id INT
               ,@ga_barcode NVARCHAR(50)
               ,@ga_code NVARCHAR(40);

        DECLARE @affected_ga_codes TABLE
        (
            fa_ga_code NVARCHAR(40) PRIMARY KEY
        );

        INSERT INTO @affected_ga_codes (fa_ga_code)
        SELECT DISTINCT fad.FA_GA_CODE
        FROM dbo.FA_REQUEST_MUTATION_DETAIL frmd WITH (NOLOCK)
        INNER JOIN dbo.FA_GROUPING_ASSET_DETAIL fad WITH (NOLOCK)
            ON frmd.ITEM_CODE = fad.BARCODE
        INNER JOIN dbo.FA_GROUPING_ASSET fa WITH (NOLOCK)
            ON fa.FA_GROUP_ASSET_CODE = fad.FA_GA_CODE
        WHERE frmd.IR_CODE = @p_code_barcode
          AND fa.IS_ACTIVE = 1
          AND fad.IS_ACTIVE = 1;

        DECLARE c_fa_grouping_delete CURSOR FAST_FORWARD LOCAL FOR
            SELECT fad.ID, fad.BARCODE
            FROM dbo.FA_REQUEST_MUTATION_DETAIL frmd WITH (NOLOCK)
            INNER JOIN dbo.FA_GROUPING_ASSET_DETAIL fad WITH (NOLOCK)
                ON frmd.ITEM_CODE = fad.BARCODE
            INNER JOIN dbo.FA_GROUPING_ASSET fa WITH (NOLOCK)
                ON fa.FA_GROUP_ASSET_CODE = fad.FA_GA_CODE
            WHERE frmd.IR_CODE = @p_code_barcode
              AND fa.IS_ACTIVE = 1
              AND fad.IS_ACTIVE = 1;

        OPEN c_fa_grouping_delete;
        FETCH NEXT FROM c_fa_grouping_delete INTO @ga_detail_id, @ga_barcode;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE dbo.FA_GROUPING_ASSET_DETAIL
            SET IS_ACTIVE = '0',
                MOD_DATE = @p_mod_date,
                MOD_BY = @p_mod_by,
                MOD_IP_ADDRESS = @p_mod_ip_address
            WHERE ID = @ga_detail_id
              AND BARCODE = @ga_barcode;

            EXEC dbo.xsp_fa_grouping_asset_history_insert
                @p_fa_ga_detail_id = @ga_detail_id,
                @p_barcode         = @ga_barcode,
                @p_action          = 'DELETE',
                @p_move_to         = '',
                @p_doc_reff_no     = @mutation_code,
                @p_cre_date        = @p_mod_date,
                @p_cre_by          = @p_mod_by,
                @p_cre_ip_address  = @p_mod_ip_address,
                @p_mod_date        = @p_mod_date,
                @p_mod_by          = @p_mod_by,
                @p_mod_ip_address  = @p_mod_ip_address;

            FETCH NEXT FROM c_fa_grouping_delete INTO @ga_detail_id, @ga_barcode;
        END;

        CLOSE c_fa_grouping_delete;
        DEALLOCATE c_fa_grouping_delete;

        EXEC dbo.xsp_fa_grouping_asset_deactivate_if_empty
            @p_source_type = 'MUTATION',
            @p_code_barcode = @p_code_barcode,
            @p_mod_by = @p_mod_by,
            @p_mod_date = @p_mod_date,
            @p_mod_ip_address = @p_mod_ip_address;

        DECLARE @current_ga_code NVARCHAR(40);
        DECLARE @new_parent_id INT;

        DECLARE c_reassign_parent CURSOR FAST_FORWARD LOCAL FOR
            SELECT fa_ga_code FROM @affected_ga_codes;

        OPEN c_reassign_parent;
        FETCH NEXT FROM c_reassign_parent INTO @current_ga_code;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM dbo.FA_GROUPING_ASSET_DETAIL
                WHERE FA_GA_CODE = @current_ga_code
                  AND IS_ACTIVE = 1
                  AND IS_PARENT = 1
            )
            BEGIN
                SET @new_parent_id = NULL;

                SELECT TOP 1 @new_parent_id = ID
                FROM dbo.FA_GROUPING_ASSET_DETAIL
                WHERE FA_GA_CODE = @current_ga_code
                  AND IS_ACTIVE = 1
                ORDER BY ID ASC;

                IF @new_parent_id IS NOT NULL
                BEGIN
                    UPDATE dbo.FA_GROUPING_ASSET_DETAIL
                    SET IS_PARENT = 1,
                        MOD_DATE = @p_mod_date,
                        MOD_BY = @p_mod_by,
                        MOD_IP_ADDRESS = @p_mod_ip_address
                    WHERE ID = @new_parent_id;
                END;
            END;

            FETCH NEXT FROM c_reassign_parent INTO @current_ga_code;
        END;

        CLOSE c_reassign_parent;
        DEALLOCATE c_reassign_parent;
    END TRY
    BEGIN CATCH
        DECLARE @ErrMSG NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        IF CURSOR_STATUS('local', 'c_fa_grouping_delete') >= 0 CLOSE c_fa_grouping_delete;
        IF CURSOR_STATUS('local', 'c_fa_grouping_delete') > -3 DEALLOCATE c_fa_grouping_delete;
        IF CURSOR_STATUS('local', 'c_reassign_parent') >= 0 CLOSE c_reassign_parent;
        IF CURSOR_STATUS('local', 'c_reassign_parent') > -3 DEALLOCATE c_reassign_parent;

        IF @v_flag_process = 'UPL'
        BEGIN
            IF OBJECT_ID('tempdb..#all_error') IS NOT NULL
               AND EXISTS (SELECT 1 FROM #all_error)
            BEGIN
                SELECT @ErrMSG = STUFF((
                    SELECT CHAR(10) + error_message
                    FROM #all_error
                    ORDER BY row_number
                    FOR XML PATH(''), TYPE
                ).value('.', 'NVARCHAR(MAX)'), 1, 1, '');
            END

            IF XACT_STATE() = 0
            BEGIN
                INSERT INTO dbo.APP_PROCESS_ERROR_LOG
                (
                    CODE_BARCODE,
                    PROCESS_NAME,
                    FILE_NAME,
                    BARCODE,
                    QUANTITY,
                    ROW_NUMBER,
                    ERROR_MESSAGE,
                    RAW_DATA,
                    CRE_BY,
                    CRE_DATE,
                    CRE_IP_ADDRESS
                )
                VALUES
                (
                    @p_code_barcode,
                    'POST_FA_MUTATION_ERROR',
                    '',
                    NULL,
                    NULL,
                    0,
                    @ErrMSG,
                    'Bulk POST FA Mutation',
                    @p_mod_by,
                    GETDATE(),
                    @p_mod_ip_address
                );
            END

            RAISERROR (@ErrMSG, 16, 1);
            RETURN;
        END

        RAISERROR (@ErrMSG, @ErrorSeverity, @ErrorState);
    END CATCH

    IF OBJECT_ID('tempdb..#all_error') IS NOT NULL DROP TABLE #all_error;
END
GO
