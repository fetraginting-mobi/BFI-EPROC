ALTER PROCEDURE [dbo].[xsp_fa_asset_getrows_for_subscription]
(
	@p_keywords			nvarchar(50)
	,@p_location		nvarchar(20)
	,@p_branch_code		NVARCHAR(20)
	,@p_owner			NVARCHAR(20)
) as
begin
	
	SELECT TOP 100	fa.barcode 'code'
			,ast_name + ' - ' + fl.LOC_NAME + ' (' + mb.DESCRIPTION + ')' 'description'
			,isnull(ga.is_parent,'No') 'parent'
			,isnull(mu.DESCRIPTION,'') 'owner'
			,isnull(ga.fa_group_asset_name,'') 'Group Asset Name'
	from	dbo.fa_asset fa
	INNER JOIN dbo.FA_LOCATION fl with (nolock) ON (fl.LOC_CODE = CURRENT_BRANCH)
	left JOIN dbo.MASTER_BRANCH mb with (nolock) ON (mb.CODE = fa.BRANCH_CODE)
	INNER JOIN dbo.MASTER_ITEM mi with (nolock) ON (mi.ITEM_CODE = fa.AST_CODE)
	left join master_units mu with (nolock) on mi.owner = mu.code and mu.IS_ACTIVE = 1 and mu.IS_OWNER = 1
	left join (
					select fgad.BARCODE, 
				case when fgad.IS_PARENT = '1' then 'Yes'
					else 'No'
					end as 'is_parent',
				fga.fa_group_asset_code,
				fga.fa_group_asset_name,
				fga.branch_code,
				fga.fa_location
				from fa_grouping_asset fga with (nolock)
				inner join fa_grouping_asset_detail fgad with (nolock) on fga.fa_group_asset_code = fgad.fa_ga_code
				where fgad.IS_ACTIVE = 1 
	) ga on fa.barcode =ga.barcode  and fl.LOC_CODE =ga.fa_location
	OUTER APPLY(
				select		fsd.BARCODE 
				from		dbo.fa_sale_detail fsd with (nolock)
				inner join	dbo.fa_sale_header fsh with (nolock) on (fsh.code_barcode = fsd.fa_sale_code)				
				where		fsh.trans_flag_code in ('NEW','ONPROGRESS')
				AND			fsd.BARCODE = fa.BARCODE
	)sale
	OUTER APPLY(
				select		item_code 
				from		dbo.fa_request_mutation_detail farm with (nolock)
				INNER JOIN	dbo.fa_request_mutation_header farh with (nolock) on (farh.code_barcode = farm.ir_code)
				where		(farm.status_received = 'SENT' or farm.status_received = 'RETURNED' or farm.status_received is null)
				AND			farm.ITEM_CODE = fa.BARCODE
	)mutation
	OUTER APPLY(
				SELECT		fdd.barcode 
				from		dbo.fa_disposal_detail fdd with (nolock)
				inner join	dbo.fa_disposal_header fdh with (nolock) on (fdh.code_barcode = fdd.fa_disposal_code)
				where		fdh.trans_flag_code in ('NEW','ONPROGRESS')
				AND			fdd.BARCODE = fa.BARCODE
	)dispose
	where	trans_flag_code = 'AVAILABLE'	
	AND dispose.BARCODE			is NULL
	AND mutation.ITEM_CODE		is NULL
	AND sale.BARCODE			is NULL
	and		(current_branch	= @p_location or @p_location = 'ALL')
	AND		fa.BRANCH_CODE	= @p_branch_code
	AND		(mi.OWNER		= @p_owner OR @p_owner = 'ALL')
	and		(
				fa.barcode				like '%'+ @p_keywords +'%'
			or	ast_code			like '%'+ @p_keywords +'%'
			or	ast_name			like '%'+ @p_keywords +'%'
			or	orig_price			like '%'+ @p_keywords +'%'
			or	net_book_value		like '%'+ @p_keywords +'%'
			)

	union all 
		select	ib.barcode as 'code'
			,ib.item_code + ' - ' + mi.item_name + ' - ' + ml.description 'description'
			,isnull(ga.is_parent,'No') 'parent'
			,isnull(mu.DESCRIPTION,'') 'owner'
			,isnull(ga.fa_group_asset_name,'') 'Group Asset Name'
		from	dbo.inventory_barcode ib
				inner join dbo.master_item mi on (ib.item_code = mi.item_code)
				inner join dbo.master_branch mb on (ib.branch_code = mb.code)
				inner join dbo.master_location ml on (ib.location_code = ml.code)
				INNER join master_units mu with (nolock) on mi.owner = mu.code and mu.IS_ACTIVE = 1 and mu.IS_OWNER = 1
				inner join (
						select fgad.BARCODE, 
							case when fgad.IS_PARENT = '1' then 'Yes'
						else 'No'
						end as 'is_parent',
					fga.fa_group_asset_code,
					fga.fa_group_asset_name,
					fga.branch_code,
					fga.fa_location
					from fa_grouping_asset fga with (nolock)
					inner join fa_grouping_asset_detail fgad with (nolock) on fga.fa_group_asset_code = fgad.fa_ga_code
					where fgad.IS_ACTIVE = 1 and fga.branch_code = @p_branch_code and fga.FA_LOCATION = @p_location
				) ga on ib.barcode =ga.barcode				
		where	ib.barcode_status = 'AVAILABLE' and mi.RENT_FLAG = 1
		AND NOT EXISTS (
			SELECT 1
			FROM (
				SELECT 
					COUNT(CASE WHEN gad.IS_PARENT = '0' THEN gad.BARCODE END) as TotalChildGrup,
					SUM(CASE WHEN gad.IS_PARENT = '0' AND tx.BARCODE IS NOT NULL THEN 1 ELSE 0 END) as TotalChildBertransaksi
				FROM dbo.fa_grouping_asset_detail gad with (nolock)
				OUTER APPLY (
					SELECT TOP 1 t.BARCODE
					FROM (
						--Sale
						SELECT fsd.BARCODE 
						FROM dbo.fa_sale_detail fsd with (nolock)
						INNER JOIN dbo.fa_sale_header fsh with (nolock) on fsh.code_barcode = fsd.fa_sale_code
						WHERE fsh.trans_flag_code in ('NEW','ONPROGRESS') AND fsd.BARCODE = gad.BARCODE
						
						UNION ALL
						--Mutation
						SELECT farm.ITEM_CODE
						FROM dbo.fa_request_mutation_detail farm with (nolock)
						INNER JOIN dbo.fa_request_mutation_header farh with (nolock) on farh.code_barcode = farm.ir_code
						WHERE (farm.status_received = 'SENT' or farm.status_received = 'RETURNED' or farm.status_received is null) 
						AND farm.ITEM_CODE = gad.BARCODE
						
						UNION ALL
						--Disposal
						SELECT fdd.BARCODE 
						FROM dbo.fa_disposal_detail fdd with (nolock)
						INNER JOIN dbo.fa_disposal_header fdh with (nolock) on fdh.code_barcode = fdd.fa_disposal_code
						WHERE fdh.trans_flag_code in ('NEW','ONPROGRESS') AND fdd.BARCODE = gad.BARCODE
					) t
				) tx
				WHERE gad.fa_ga_code = ga.fa_group_asset_code AND gad.IS_ACTIVE = 1
			) SummaryGrup
			WHERE ga.is_parent = 'Yes' 
			  AND SummaryGrup.TotalChildGrup > 0 
			  AND SummaryGrup.TotalChildGrup = SummaryGrup.TotalChildBertransaksi
		)

		AND		(
						ib.barcode					like '%' + @p_keywords + '%'
					or  ib.ITEM_CODE				like '%' + @p_keywords + '%'
					or	mi.item_name					like '%' + @p_keywords + '%'
					or	ml.description					like '%' + @p_keywords + '%'
				)	
end
GO


