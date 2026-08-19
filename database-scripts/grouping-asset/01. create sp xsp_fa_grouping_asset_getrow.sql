CREATE PROCEDURE [dbo].[xsp_fa_grouping_asset_getrow]
(
	@p_fa_group_asset_code			nvarchar(10)
)
as
begin
	select  
		fga.fa_group_asset_code,
		fga.fa_group_asset_name,
		fga.remarks,
		fga.branch_code 'cost_center',
		fga.fa_location 'fa_location',
		fga.cre_date,
		em.emp_name as cre_by, 
		fga.mod_date,
		em1.emp_name as mod_by,
		fgad.barcode,
		fgad.name_asset,
		fgad.is_parent,
		fga.is_active
	from fa_grouping_asset fga
	outer apply (
		select top 1 *
		from fa_grouping_asset_detail d
		where d.fa_ga_code = fga.fa_group_asset_code
		  and d.is_parent = 1
		  and d.is_active = 1
	) fgad
	left join employee_main em on (fga.cre_by = em.emp_code)
	left join employee_main em1 on (fga.mod_by = em1.emp_code)
	where 
		fga.fa_group_asset_code = @p_fa_group_asset_code
		--and fga.is_active = 1;
end 
GO


