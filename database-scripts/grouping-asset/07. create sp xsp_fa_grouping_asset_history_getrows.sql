CREATE procedure [dbo].[xsp_fa_grouping_asset_history_getrows]
(
	@p_keywords			nvarchar(50)
	,@p_fa_group_asset_code	nvarchar(18)
)as
begin
select 
	fgad.id 'historyid'
	,fgah.barcode 'barcode'
	,fgad.fa_ga_code 'group_asset_code'
	,fgad.name_asset	'item_name'
	,fc.cat_name 		'asset_category'
	,'' as 'doc_reff_no'
	,'' as 'pic_from'
	,'' as 'branch_from'
	,'' as 'pic_to'
	,'' as 'branch_to'
	,CASE 
            WHEN fgah.action = 'create' THEN 'New Grouping'
            WHEN fgah.action = 'delete' THEN 'Remove From Grouping'
            WHEN fgah.action = 'move_out'   THEN 'Move Grouping Out'
			WHEN fgah.action = 'move_in'   THEN 'Move Grouping In'
            ELSE fgah.action 
        END AS 'action'
	,move_to 'move to'
	,fgah.cre_date 'cre_date'
	,fgah.mod_date 'mod_date'
from fa_grouping_asset_history fgah with (nolock)
inner join fa_grouping_asset_detail fgad with (nolock) on fgah.fa_ga_detail_id = fgad.id and fgah.barcode = fgad.barcode
left join fa_asset fa with (nolock) on (fgad.code_asset = fa.ast_code and fgad.fa_asset_id = fa.id and fgad.barcode =fa.barcode)
left join dbo.fa_category fc with (nolock) on (fc.cat_code = fa.cat_code)
where fgad.fa_ga_code = @p_fa_group_asset_code 
and 
		(
					fgad.code_asset													like '%'+ @p_keywords +'%'
				or	fgad.name_asset													like '%'+ @p_keywords +'%'
				or	fgah.barcode														like '%'+ @p_keywords +'%'
		 )
order by fgah.barcode,fgah.cre_date desc
end 
GO


