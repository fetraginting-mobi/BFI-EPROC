CREATE PROCEDURE [dbo].[xsp_inv_mutation_detail_upload_getrows]
(
    @p_upload_id UNIQUEIDENTIFIER
    --,@p_file_name NVARCHAR(255)
    ,@p_status    NVARCHAR(30)
)
AS
BEGIN
    SELECT 
        imus.[row_number], 
        imus.item_code as 'BARCODE', 
		mi.item_name,
        imus.quantity, 
        imus.[error_message], 
        (
            CASE WHEN process_flag = 'e' THEN 'Error'
                 ELSE 'Success'
            END
        ) AS process_flag
    FROM inv_mutation_upload_staging imus
	left join MASTER_ITEM mi on mi.ITEM_CODE = imus.item_code
    WHERE upload_id = @p_upload_id
      AND process_flag = (
        CASE WHEN @p_status = 'VALID' THEN 's'
             WHEN @p_status = 'ERROR' THEN 'e'
        END
		)
	  --AND file_name = @p_file_name
    GROUP BY 
        imus.upload_id, 
        imus.[row_number], 
        imus.item_code, 
		mi.item_name,
        imus.quantity, 
        imus.[error_message], 
        imus.process_flag;
END
GO


