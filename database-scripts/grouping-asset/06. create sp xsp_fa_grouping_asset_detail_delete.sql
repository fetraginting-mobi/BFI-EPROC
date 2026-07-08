CREATE PROCEDURE [dbo].[xsp_fa_grouping_asset_detail_delete]
(
	@p_id		int
)as
begin
	
	declare @is_parent INT

	
	SELECT @is_parent = COUNT(1)
    FROM dbo.fa_grouping_asset_detail
    WHERE id = @p_id
      AND IS_PARENT =1


	if @is_parent = 1
		begin
			raiserror ('Asset Parent tidak dapat di hapus',16 , 1)
		return
	end

	delete	fa_grouping_asset_detail
	where	id	= @p_id
	
end

GO


