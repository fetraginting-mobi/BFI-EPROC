create procedure [dbo].[xsp_master_item_document_history_getrows]
(
	@p_item_code	         nvarchar(50)
)as
begin

	select	mid.remarks
			,mid.paths
			,[file] 'file'
			,paths
			,[action]
			,mid.id
			,mid.item_code
			,mid.mod_date
	from	dbo.master_item_document_history mid
	where	mid.item_code = @p_item_code
	order by mid.mod_date desc
end


