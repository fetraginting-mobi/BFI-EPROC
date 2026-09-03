ALTER PROCEDURE [dbo].[xsp_inventory_mutation_upload_staging_log_getrows]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        s.upload_id,
		concat(s.upload_by, ' - ', em.EMP_NAME) 'upload_by',
        s.file_name AS file_name,
        CONVERT(VARCHAR(10), MAX(s.upload_date), 103) + ' ' +
        CONVERT(VARCHAR(8), MAX(s.upload_date), 108) AS UPLOAD_DATE,
        COUNT(*) AS total_rows,
        SUM(CASE WHEN s.process_flag = 's' THEN 1 ELSE 0 END) AS total_valid,
        SUM(CASE WHEN s.process_flag = 'e' THEN 1 ELSE 0 END) AS total_error,
        COUNT(DISTINCT CASE
            WHEN s.process_flag = 's' AND s.im_code IS NOT NULL AND imh.code IS NOT NULL THEN s.im_code
            ELSE NULL
        END) AS total_trx_upload
    FROM inv_mutation_upload_staging s
        LEFT JOIN inventory_mutation_header imh ON imh.code = s.im_code
	LEFT join EMPLOYEE_MAIN em on s.upload_by = EMP_CODE
    GROUP BY s.upload_id, s.file_name,s.upload_by,em.EMP_NAME
    ORDER BY MAX(s.upload_date) DESC;
END
GO
