CREATE procedure [dbo].[xsp_fa_grouping_asset_update]
(
    @p_fa_group_asset_code   nvarchar(15),
	@p_fa_group_asset_name  nvarchar(200),
    @p_mod_date             datetime,
    @p_mod_by               nvarchar(15),
    @p_mod_ip_address       nvarchar(15),
	@p_remarks				nvarchar(400),
	@p_status				bit
)
as
begin 
 set nocount on;
 update fa_grouping_asset
    set fa_group_asset_name = @p_fa_group_asset_name,
		is_active = @p_status,
	    mod_date       = @p_mod_date,
        mod_by         = @p_mod_by,
        mod_ip_address = @p_mod_ip_address
    where fa_group_asset_code = @p_fa_group_asset_code;
end
GO


