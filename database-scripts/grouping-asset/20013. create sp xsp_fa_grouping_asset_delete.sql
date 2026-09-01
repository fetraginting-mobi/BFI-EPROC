create PROCEDURE [dbo].[xsp_fa_grouping_asset_delete]
(	
	@p_fa_group_asset_code		nvarchar(20)
)as
begin
	
	update	fa_grouping_asset_detail 
	set IS_ACTIVE ='0', MOD_DATE=getdate()
	where	fa_ga_code = @p_fa_group_asset_code and IS_ACTIVE ='1'

	update	fa_grouping_asset 
	set IS_ACTIVE ='0', MOD_DATE=getdate()
	where	fa_group_asset_code = @p_fa_group_asset_code	
end

GO


