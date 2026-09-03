ALTER PROCEDURE [dbo].[xsp_fa_mutation_upload_staging_log_getrows]
AS
BEGIN
    SELECT 
        upload_id,
		concat(s.upload_by, ' - ', em.EMP_NAME) 'upload_by',
        [file_name] AS file_name, 
        CONVERT(VARCHAR(10), MAX(upload_date), 103) + ' ' + 
        CONVERT(VARCHAR(8), MAX(upload_date), 108) AS UPLOAD_DATE, 
        COUNT(*) AS total_rows,    
        SUM(CASE WHEN process_flag = 's' THEN 1 ELSE 0 END) AS total_valid,
        SUM(CASE WHEN process_flag = 'e' THEN 1 ELSE 0 END) AS total_error,
		COUNT(DISTINCT CASE
            WHEN s.process_flag = 's' AND s.fm_code IS NOT NULL AND frmh.code IS NOT NULL THEN s.fm_code
            ELSE NULL
        END) AS total_trx_upload
    FROM fa_mutation_upload_staging s with (nolock)
		LEFT JOIN FA_REQUEST_MUTATION_HEADER frmh with (nolock) ON frmh.code = s.fm_code
		LEFT join EMPLOYEE_MAIN em with (nolock) on s.upload_by = EMP_CODE
    --WHERE upload_id = @p_upload_id
    GROUP BY s.upload_id, s.file_name,s.upload_by,em.EMP_NAME
	order by max(upload_date) desc
END
GO


