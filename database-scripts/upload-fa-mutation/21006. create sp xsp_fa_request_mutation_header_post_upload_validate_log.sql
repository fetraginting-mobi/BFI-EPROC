IF OBJECT_ID('[dbo].[xsp_fa_request_mutation_header_post_upload_validate_log]', 'P') IS NULL
    EXEC('CREATE PROCEDURE [dbo].[xsp_fa_request_mutation_header_post_upload_validate_log] AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROCEDURE [dbo].[xsp_fa_request_mutation_header_post_upload_validate_log]
(
    @p_code_barcode      NVARCHAR(28),
    @p_mod_by            NVARCHAR(50),
    @p_mod_ip_address    NVARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.FA_REQUEST_MUTATION_HEADER WITH (NOLOCK)
        WHERE CODE_BARCODE = @p_code_barcode
            AND ISNULL(FLAG_PROCESS, '') = 'UPL'
    )
        RETURN;

    DELETE FROM dbo.APP_PROCESS_ERROR_LOG
    WHERE CODE_BARCODE = @p_code_barcode
        AND PROCESS_NAME = 'POST_FA_MUTATION_VALIDATE';

    ;WITH ValidationError AS
    (
        SELECT
            h.CODE_BARCODE AS IR_CODE,
            d.ITEM_CODE,
            CAST(NULL AS DECIMAL(18, 2)) AS QUANTITY,
            1 AS PRIORITY,
            'Asset Code is required.' AS ERROR_MESSAGE,
            'Asset:-|From:' + ISNULL(h.FROM_LOCATION_CODE, '-') + '|To:' + ISNULL(h.TO_LOCATION_CODE, '-') AS RAW_DATA
        FROM dbo.FA_REQUEST_MUTATION_HEADER h WITH (NOLOCK)
            LEFT JOIN dbo.FA_REQUEST_MUTATION_DETAIL d WITH (NOLOCK) ON d.IR_CODE = h.CODE_BARCODE
        WHERE h.CODE_BARCODE = @p_code_barcode
            AND ISNULL(h.FLAG_PROCESS, '') = 'UPL'
            AND (d.ID IS NULL OR ISNULL(d.ITEM_CODE, '') = '')

        UNION ALL
        SELECT
            h.CODE_BARCODE AS IR_CODE,
            d.ITEM_CODE,
            CAST(NULL AS DECIMAL(18, 2)) AS QUANTITY,
            2 AS PRIORITY,
            'Invalid Asset Code.' AS ERROR_MESSAGE,
            'Asset:' + ISNULL(d.ITEM_CODE, '-') + '|From:' + ISNULL(d.LOCATION_CODE, '-') + '|To:' + ISNULL(d.TO_LOCATION_CODE, '-') AS RAW_DATA
        FROM dbo.FA_REQUEST_MUTATION_HEADER h WITH (NOLOCK)
            JOIN dbo.FA_REQUEST_MUTATION_DETAIL d WITH (NOLOCK) ON d.IR_CODE = h.CODE_BARCODE
            LEFT JOIN dbo.FA_ASSET fa WITH (NOLOCK) ON fa.BARCODE COLLATE database_default = d.ITEM_CODE COLLATE database_default
        WHERE h.CODE_BARCODE = @p_code_barcode
            AND ISNULL(h.FLAG_PROCESS, '') = 'UPL'
            AND ISNULL(d.ITEM_CODE, '') <> ''
            AND fa.BARCODE IS NULL

        UNION ALL
        SELECT
            h.CODE_BARCODE AS IR_CODE,
            d.ITEM_CODE,
            CAST(NULL AS DECIMAL(18, 2)) AS QUANTITY,
            3 AS PRIORITY,
            'Asset status must be Available.' AS ERROR_MESSAGE,
            'Asset:' + ISNULL(d.ITEM_CODE, '-') + '|Status:' + ISNULL(fa.TRANS_FLAG_CODE, '-') AS RAW_DATA
        FROM dbo.FA_REQUEST_MUTATION_HEADER h WITH (NOLOCK)
            JOIN dbo.FA_REQUEST_MUTATION_DETAIL d WITH (NOLOCK) ON d.IR_CODE = h.CODE_BARCODE
            JOIN dbo.FA_ASSET fa WITH (NOLOCK) ON fa.BARCODE COLLATE database_default = d.ITEM_CODE COLLATE database_default
        WHERE h.CODE_BARCODE = @p_code_barcode
            AND ISNULL(h.FLAG_PROCESS, '') = 'UPL'
            AND ISNULL(fa.TRANS_FLAG_CODE, '') <> 'available'

        UNION ALL
        SELECT
            h.CODE_BARCODE AS IR_CODE,
            d.ITEM_CODE,
            CAST(NULL AS DECIMAL(18, 2)) AS QUANTITY,
            4 AS PRIORITY,
            'Asset is not located at mutation from location.' AS ERROR_MESSAGE,
            'Asset:' + ISNULL(d.ITEM_CODE, '-') + '|AssetLocation:' + ISNULL(fa.CURRENT_BRANCH, '-') + '|From:' + ISNULL(d.LOCATION_CODE, '-') AS RAW_DATA
        FROM dbo.FA_REQUEST_MUTATION_HEADER h WITH (NOLOCK)
            JOIN dbo.FA_REQUEST_MUTATION_DETAIL d WITH (NOLOCK) ON d.IR_CODE = h.CODE_BARCODE
            JOIN dbo.FA_ASSET fa WITH (NOLOCK) ON fa.BARCODE COLLATE database_default = d.ITEM_CODE COLLATE database_default
        WHERE h.CODE_BARCODE = @p_code_barcode
            AND ISNULL(h.FLAG_PROCESS, '') = 'UPL'
            AND ISNULL(fa.CURRENT_BRANCH, '') <> ISNULL(d.LOCATION_CODE, '')

        UNION ALL
        SELECT
            h.CODE_BARCODE AS IR_CODE,
            d.ITEM_CODE,
            CAST(NULL AS DECIMAL(18, 2)) AS QUANTITY,
            5 AS PRIORITY,
            'Asset is currently being processed for Sale (code_barcode: ' + fsh.CODE_BARCODE + ')' AS ERROR_MESSAGE,
            'Asset:' + ISNULL(d.ITEM_CODE, '-') AS RAW_DATA
        FROM dbo.FA_REQUEST_MUTATION_HEADER h WITH (NOLOCK)
            JOIN dbo.FA_REQUEST_MUTATION_DETAIL d WITH (NOLOCK) ON d.IR_CODE = h.CODE_BARCODE
            JOIN dbo.FA_SALE_DETAIL fsd WITH (NOLOCK) ON fsd.BARCODE COLLATE database_default = d.ITEM_CODE COLLATE database_default
            JOIN dbo.FA_SALE_HEADER fsh WITH (NOLOCK) ON fsh.CODE_BARCODE = fsd.FA_SALE_CODE
        WHERE h.CODE_BARCODE = @p_code_barcode
            AND ISNULL(h.FLAG_PROCESS, '') = 'UPL'
            AND ISNULL(fsh.TRANS_FLAG_CODE, '') <> 'CANCEL'

        UNION ALL
        SELECT
            h.CODE_BARCODE AS IR_CODE,
            d.ITEM_CODE,
            CAST(NULL AS DECIMAL(18, 2)) AS QUANTITY,
            6 AS PRIORITY,
            'Asset is currently being processed for Disposal (code_barcode: ' + fdh.CODE_BARCODE + ')' AS ERROR_MESSAGE,
            'Asset:' + ISNULL(d.ITEM_CODE, '-') AS RAW_DATA
        FROM dbo.FA_REQUEST_MUTATION_HEADER h WITH (NOLOCK)
            JOIN dbo.FA_REQUEST_MUTATION_DETAIL d WITH (NOLOCK) ON d.IR_CODE = h.CODE_BARCODE
            JOIN dbo.FA_DISPOSAL_DETAIL fdd WITH (NOLOCK) ON fdd.BARCODE COLLATE database_default = d.ITEM_CODE COLLATE database_default
            JOIN dbo.FA_DISPOSAL_HEADER fdh WITH (NOLOCK) ON fdh.CODE_BARCODE = fdd.FA_DISPOSAL_CODE
        WHERE h.CODE_BARCODE = @p_code_barcode
            AND ISNULL(h.FLAG_PROCESS, '') = 'UPL'
            AND ISNULL(fdh.TRANS_FLAG_CODE, '') <> 'CANCEL'

        UNION ALL
        SELECT
            h.CODE_BARCODE AS IR_CODE,
            d.ITEM_CODE,
            CAST(NULL AS DECIMAL(18, 2)) AS QUANTITY,
            7 AS PRIORITY,
            'Asset is currently being processed for Mutation (code_barcode: ' + farh.CODE_BARCODE + ')' AS ERROR_MESSAGE,
            'Asset:' + ISNULL(d.ITEM_CODE, '-') AS RAW_DATA
        FROM dbo.FA_REQUEST_MUTATION_HEADER h WITH (NOLOCK)
            JOIN dbo.FA_REQUEST_MUTATION_DETAIL d WITH (NOLOCK) ON d.IR_CODE = h.CODE_BARCODE
            JOIN dbo.FA_REQUEST_MUTATION_DETAIL farm WITH (NOLOCK) ON farm.ITEM_CODE COLLATE database_default = d.ITEM_CODE COLLATE database_default
            JOIN dbo.FA_REQUEST_MUTATION_HEADER farh WITH (NOLOCK) ON farh.CODE_BARCODE = farm.IR_CODE
        WHERE h.CODE_BARCODE = @p_code_barcode
            AND ISNULL(h.FLAG_PROCESS, '') = 'UPL'
            AND farh.CODE_BARCODE <> @p_code_barcode
            AND (farm.STATUS_RECEIVED IN ('sent', 'returned') OR farm.STATUS_RECEIVED IS NULL)
    )
    INSERT INTO dbo.APP_PROCESS_ERROR_LOG
    (
        CODE_BARCODE,
        PROCESS_NAME,
        BARCODE,
        QUANTITY,
        ROW_NUMBER,
        ERROR_MESSAGE,
        RAW_DATA,
        CRE_DATE,
        CRE_BY,
        CRE_IP_ADDRESS
    )
    SELECT
        IR_CODE,
        'POST_FA_MUTATION_VALIDATE',
        ISNULL(ITEM_CODE, '-'),
        QUANTITY,
        ROW_NUMBER() OVER (ORDER BY PRIORITY, ITEM_CODE),
        ERROR_MESSAGE,
        RAW_DATA,
        GETDATE(),
        @p_mod_by,
        @p_mod_ip_address
    FROM ValidationError;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.APP_PROCESS_ERROR_LOG WITH (NOLOCK)
        WHERE CODE_BARCODE = @p_code_barcode
            AND PROCESS_NAME = 'POST_FA_MUTATION_VALIDATE'
    )
    BEGIN
        RAISERROR ('Proses posting bulk dibatalkan karena tidak lolos validasi data detail. Silakan cek tab Error Upload Mutation History.', 16, 1);
        RETURN;
    END
END
GO

