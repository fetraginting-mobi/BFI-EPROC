CREATE PROCEDURE [dbo].[xsp_fa_grouping_asset_insert]
(
	 @p_fa_group_asset_code					nvarchar(10) output
	,@p_fa_group_asset_name					nvarchar(100)
	,@p_remarks								nvarchar(100)
	,@p_cost_center							nvarchar(10)	--johan 2015-10-09
	,@p_fa_location							nvarchar(50)
	,@p_status								bit
	,@p_cre_date							datetime
	,@p_cre_by								nvarchar(15)
	,@p_cre_ip_address						nvarchar(15)
	,@p_mod_date							datetime
	,@p_mod_by								nvarchar(15)
	,@p_mod_ip_address						nvarchar(15)
)as
begin

	declare @group_asset_sequence		nvarchar(6)
	set @group_asset_sequence = [dbo].[fn_get_next_fa_grouping_asset_sequence]()
	set @p_fa_group_asset_code = 'ITGR' + @group_asset_sequence 

	insert into fa_grouping_asset
	(
		fa_group_asset_code
		,FA_GROUP_ASSET_NAME
		,REMARKS
		,branch_code
		,fa_location
		,is_active
		,cre_date
		,cre_by
		,cre_ip_address
		,mod_date
		,mod_by
		,mod_ip_address
		,GROUP_ASSET_SEQUENCE
	)
	values
	(
		@p_fa_group_asset_code
		,@p_fa_group_asset_name
		,@p_remarks
		,@p_cost_center
		,@p_fa_location
		,ISNULL(@p_status, 1)	
		,@p_cre_date
		,@p_cre_by
		,@p_cre_ip_address
		,@p_mod_date
		,@p_mod_by
		,@p_mod_ip_address
		,@group_asset_sequence
	)
end
	


GO


