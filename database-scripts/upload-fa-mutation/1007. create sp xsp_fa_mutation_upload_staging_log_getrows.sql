CREATE PROCEDURE [dbo].[xsp_fa_mutation_upload_staging_log_getrows]
AS
BEGIN
    SELECT 
        upload_id,
		upload_by,
        [file_name] AS file_name, 
        CONVERT(VARCHAR(10), MAX(upload_date), 103) + ' ' + 
        CONVERT(VARCHAR(8), MAX(upload_date), 108) AS UPLOAD_DATE, 
        COUNT(*) AS total_rows,    
        SUM(CASE WHEN process_flag = 's' THEN 1 ELSE 0 END) AS total_valid,
        SUM(CASE WHEN process_flag = 'e' THEN 1 ELSE 0 END) AS total_error,
		'' AS 'total_trx_upload'
    FROM fa_mutation_upload_staging
    --WHERE upload_id = @p_upload_id
    GROUP BY upload_id,file_name,upload_by
	order by upload_date desc
END
GO


