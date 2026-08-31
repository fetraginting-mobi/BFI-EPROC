CREATE PROCEDURE [dbo].[xsp_fa_grouping_asset_getrows_subsciption]
(
	@p_keywords			nvarchar(50)
	,@p_fa_group_asset_code	nvarchar(20)
)as
begin
	select  BARCODE			'code'
			,DESCRIPTION	'description'
			,fa_ga_code
			,CODE_ASSET
			,NAME_ASSET

	from	fa_grouping_asset_detail 
	where fa_ga_code = @p_fa_group_asset_code 
	and		IS_ACTIVE = '1'
	and
		(
					CODE_ASSET													like '%'+ @p_keywords +'%'
				or	NAME_ASSET													like '%'+ @p_keywords +'%'
				or	BARCODE														like '%'+ @p_keywords +'%'
		)
	
end

