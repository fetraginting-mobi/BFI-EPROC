CREATE PROCEDURE [dbo].[xsp_master_item_document_getrows]
(
	@p_keywords			nvarchar(50)
	,@p_item_code	         NVARCHAR(50)
)as
begin

	select	mid.remarks
			,mid.paths
			,[FILE] 'file'
			,PATHS
			,mid.remarks 'description'
			,mid.id
			,mid.ITEM_CODE
			,mid.SEQUENCE_no
			,mid.mod_date
	from	dbo.master_item_document mid
	where	mid.ITEM_CODE = @p_item_code
			and IS_ACTIVE = 1
	and		
	        (
					mid.paths					like '%' + @p_keywords + '%'
				or	mid.remarks		LIKE '%' + @p_keywords + '%'
			)	
	order by mid.SEQUENCE_no desc
end

GO


