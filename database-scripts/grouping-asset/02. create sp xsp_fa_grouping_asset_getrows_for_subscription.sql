CREATE PROCEDURE [dbo].[xsp_fa_grouping_asset_getrows_for_subscription]
(
	@p_keywords			nvarchar(50)
	,@p_branch_code		NVARCHAR(20)
	,@p_location		nvarchar(20)
)
as

begin	
	select top 100	
		fa.barcode as 'code'
		,fa.ast_name + ' - ' + fl.loc_name + ' (' + mb.description + ')' as 'description'
		,fc.cat_name as 'category'
		,mu.DESCRIPTION 'owner'
	from dbo.fa_asset fa with (nolock)
	left join dbo.fa_category fc with (nolock) on (fc.cat_code = fa.cat_code)
	inner join dbo.fa_location fl with (nolock) on (fl.loc_code = current_branch)
	left join dbo.master_branch mb with (nolock) on (mb.code = fa.branch_code)
	inner join dbo.master_item mi with (nolock) on (mi.item_code = fa.ast_code)
	INNER join master_units mu with (nolock) on mi.owner = mu.code and mu.IS_ACTIVE = 1 and mu.IS_OWNER = 1
	outer apply(
				select barcode 
				from dbo.fa_sale_detail fsd with (nolock)
				inner join dbo.fa_sale_header fsh with (nolock) on (fsh.code_barcode = fsd.fa_sale_code)
				where fsh.trans_flag_code in ('new','onprogress')
				and fsd.barcode = fa.barcode
	)sale
	outer apply(
				select	item_code 
				from dbo.fa_request_mutation_detail farm with (nolock)
				inner join dbo.fa_request_mutation_header farh with (nolock) on (farh.code_barcode = farm.ir_code)
				where (farm.status_received = 'sent' or farm.status_received = 'returned' or farm.status_received is null)
				and farm.item_code = fa.barcode
	)mutation
	outer apply(
				select fdd.barcode 
				from dbo.fa_disposal_detail fdd with (nolock)
				inner join dbo.fa_disposal_header fdh with (nolock) on (fdh.code_barcode = fdd.fa_disposal_code)
				where fdh.trans_flag_code in ('new','onprogress')
				and fdd.barcode = fa.barcode
	)dispose
	outer apply (
				select top 1 1 as flag_exist
				from fa_grouping_asset fga with (nolock)
				inner join fa_grouping_asset_detail fgad with (nolock) on fga.fa_group_asset_code = fgad.fa_ga_code
				where fga.branch_code = @p_branch_code
				  and fga.fa_location = @p_location
				  and fgad.code_asset = fa.ast_code
				  and fgad.is_active = 1   
	) grouping_asset
	where	fa.trans_flag_code = 'available'	
	and dispose.barcode			is null
	and mutation.item_code		is null
	and sale.barcode			is null
	and grouping_asset.flag_exist	is null
	and	fa.branch_code	= @p_branch_code
	and	current_branch	= @p_location 
	and	(
			fa.barcode				like '%'+ @p_keywords +'%'
			or	fa.ast_code			like '%'+ @p_keywords +'%'
			or	fa.ast_name			like '%'+ @p_keywords +'%'
		)

   union all 
		select	ib.barcode as 'code'
			,ib.item_code + ' - ' + mi.item_name + ' - ' + ml.description 'description'
			,'-' 'category'
			,mu.DESCRIPTION 'owner'
	from	dbo.inventory_barcode ib
			inner join dbo.master_item mi on (ib.item_code = mi.item_code)
			inner join dbo.master_branch mb on (ib.branch_code = mb.code)
			inner join dbo.master_location ml on (ib.location_code = ml.code)
			INNER join master_units mu with (nolock) on mi.owner = mu.code and mu.IS_ACTIVE = 1 and mu.IS_OWNER = 1
			outer apply (
				select top 1 1 as flag_exist
				from fa_grouping_asset fga with (nolock)
				inner join fa_grouping_asset_detail fgad with (nolock) on fga.fa_group_asset_code = fgad.fa_ga_code
				where fga.branch_code = @p_branch_code
				  and fga.fa_location = @p_location
				  and fgad.BARCODE = ib.BARCODE
				  and fgad.is_active = 1   
			) grouping_asset
	where	ib.barcode_status = 'AVAILABLE' and mi.RENT_FLAG = 1
	and grouping_asset.flag_exist	is null
	and		(ib.branch_code			= @p_branch_code OR @p_branch_code	= 'ALL')
	AND		(
					ib.barcode					like '%' + @p_keywords + '%'
				or  ib.ITEM_CODE				like '%' + @p_keywords + '%'
				or	mi.item_name					like '%' + @p_keywords + '%'
				or	ml.description					like '%' + @p_keywords + '%'
			)	
end
GO


