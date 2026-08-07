CREATE PROCEDURE [dbo].[xsp_fa_mutation_upload_generated_trx_getrows]
(
    @p_upload_id UNIQUEIDENTIFIER,
    @p_file_name NVARCHAR(255) = '',
    @p_keywords NVARCHAR(100) = ''
)
AS
BEGIN
    SET NOCOUNT ON;

    SET @p_file_name = ISNULL(@p_file_name, '');
    SET @p_keywords = ISNULL(@p_keywords, '');

    SELECT
        ROW_NUMBER() OVER (ORDER BY x.code) AS row_number,
        x.code AS BARCODE,
        CAST('' AS NVARCHAR(255)) AS item_name,
        x.trans_flag_code AS process_flag,
        CAST('' AS NVARCHAR(500)) AS ERROR_MESSAGE
    FROM (
        SELECT DISTINCT
            h.code,
            h.trans_flag_code
        FROM fa_mutation_upload_staging s
        JOIN FA_REQUEST_MUTATION_DETAIL d
            ON d.ITEM_CODE COLLATE database_default = s.asset_code COLLATE database_default
        JOIN FA_REQUEST_MUTATION_HEADER h
            ON h.code_barcode = d.IR_CODE
            AND h.BRANCH_CODE COLLATE database_default = s.from_cost_center COLLATE database_default
            AND h.FROM_LOCATION_CODE COLLATE database_default = s.from_location COLLATE database_default
            AND h.to_cost_center COLLATE database_default = s.to_cost_center COLLATE database_default
            AND h.TO_LOCATION_CODE COLLATE database_default = s.to_location COLLATE database_default
            AND h.owner COLLATE database_default = s.owner COLLATE database_default
        WHERE s.upload_id = @p_upload_id
            AND (@p_file_name = '' OR s.file_name = @p_file_name)
            AND s.process_flag = 's'
            AND h.FLAG_PROCESS = 'UPL'
            AND h.REMARKS = 'bulk upload mutation'
            AND (
                @p_keywords = ''
                OR h.code LIKE '%' + @p_keywords + '%'
                OR h.trans_flag_code LIKE '%' + @p_keywords + '%'
            )
    ) x
    ORDER BY x.code;
END
GO
