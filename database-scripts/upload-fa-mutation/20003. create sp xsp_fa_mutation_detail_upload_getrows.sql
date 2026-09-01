CREATE PROCEDURE [dbo].[xsp_fa_mutation_detail_upload_getrows]
(
    @p_upload_id UNIQUEIDENTIFIER
    ,@p_status    NVARCHAR(30)
)
AS
BEGIN
        SELECT 
        fmus.[row_number], 
        fmus.asset_code as 'BARCODE', 
		fa.ast_name 'item_name',
        fmus.[error_message], 
        (
            CASE WHEN process_flag = 'e' THEN 'Error'
                 ELSE 'Success'
            END
        ) AS process_flag
    FROM fa_mutation_upload_staging fmus
	left join fa_asset fa on fmus.asset_code = fa.barcode
	left join MASTER_ITEM mi on fa.ast_code = mi.ITEM_CODE
    WHERE upload_id = @p_upload_id
      AND process_flag = (
        CASE WHEN @p_status = 'VALID' THEN 's'
             WHEN @p_status = 'ERROR' THEN 'e'
        END
		)
    GROUP BY 
        fmus.upload_id, 
        fmus.[row_number],
		fmus.asset_code, 
		fa.ast_name,
        fmus.[error_message], 
        fmus.process_flag
END
GO


