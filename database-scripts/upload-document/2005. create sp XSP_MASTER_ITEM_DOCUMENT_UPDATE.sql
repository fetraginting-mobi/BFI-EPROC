CREATE PROCEDURE [dbo].[XSP_MASTER_ITEM_DOCUMENT_UPDATE]
(
	 @p_id				int
	,@p_item_code        NVARCHAR(50)
    ,@p_cre_by	         NVARCHAR(15)
    ,@p_cre_ip_address   NVARCHAR(15)
)
AS
BEGIN
    SET NOCOUNT ON;

	UPDATE MASTER_ITEM_DOCUMENT
		SET IS_ACTIVE = 0
	where ID = @p_id AND ITEM_CODE = @p_item_code

    DECLARE @p_remarks nvarchar(500), 
			@p_file	   nvarchar(500),
			@p_paths   nvarchar(500);
	
  select @p_remarks = remarks,
		 @p_file	= [file],
		 @p_paths	= PATHS
	from MASTER_ITEM_DOCUMENT  
  where ID = @p_id AND ITEM_CODE = @p_item_code

	EXEC [dbo].[xsp_master_item_document_history_insert]
        @p_item_document_id = @p_id, 
        @p_item_code        = @p_item_code,
		@p_remarks			= @p_remarks,
        @p_action			='DELETE', 
        @p_file				= @p_file,
		@p_paths			= @p_paths,
        @p_cre_by			= @p_cre_by,
        @p_cre_ip_address   = @p_cre_ip_address
    
END
GO


