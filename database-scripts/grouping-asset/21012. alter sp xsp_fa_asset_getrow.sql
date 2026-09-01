ALTER PROCEDURE [dbo].[xsp_fa_asset_getrow]
(
	@p_id		int
)as
begin

	declare @barcode					nvarchar(30)
			,@amount_maintenance		decimal(18,2)
			,@amount_maintenance_aip	decimal(18,2)
			,@total_asset_maintenance	decimal(18,2)
			,@request_no				nvarchar(50) -- (+) Ari 20-01-2023
			,@staff						nvarchar(15) -- (+) Ari 20-01-2023
			,@staff_name				nvarchar(100)-- (+) Ari 20-01-2023
			,@grouping_asset_name		nvarchar(100)
			,@grouping_asset_id			nvarchar(100)

	select @barcode = barcode
	from dbo.fa_asset
	where id = @p_id

	set @amount_maintenance_aip = 0
	select @amount_maintenance_aip = sum(f9)
	from dbo.[___maintenance_asset]
	where barcode = @barcode

	-- Iproc Phase III 
	select 
		@grouping_asset_name = isnull(fga.fa_group_asset_name ,''), 
		@grouping_asset_id = isnull(fga.fa_group_asset_code ,'') 
	from fa_asset fa with (nolock)
	inner join fa_grouping_asset_detail fgad with (nolock) on fa.id =fgad.fa_asset_id and fa.ast_code = fgad.code_asset and fa.barcode = fgad.barcode and fgad.is_active=1
	inner join fa_grouping_asset fga with (nolock) on fga.fa_group_asset_code = fgad.fa_ga_code and fga.is_active=1
	where fgad.barcode = @barcode

	select	TOP 1 @request_no = isnull(request_no,'') --2409000007 ali add validasi untuk get latest data request peralatan kerja
	from	dbo.request_peralatan_kerja_detail rpkd
	inner	join dbo.fa_asset fa on (rpkd.item_code = fa.barcode)
	where	item_code = @barcode
	and		fa.used = '1'
	ORDER BY rpkd.ID DESC --2409000007 ali add validasi untuk get latest data request peralatan kerja

	select	@staff = isnull(staff ,'')
	from	dbo.request_peralatan_kerja_header
	where	request_no = @request_no

	select	@staff_name = isnull(emp_name ,'')
	from	dbo.employee_main
	where	emp_code = @staff
	-- (+) Ari 20-01-2023

	SET @amount_maintenance = 0
	SELECT @amount_maintenance =	SUM(fam.TRX_AMOUNT)
	from	FA_ASSET_MAINTENANCE fam
			left JOIN dbo.FA_ASSET fa ON (fa.BARCODE = fam.BARCODE)
			left JOIN dbo.AP_INVOICE_REGISTRATION_HEADER airh ON (airh.CODE = fam.RECEIPT_NO)
			left JOIN dbo.FA_ASSET_MAINTENANCE_SERVICE fams ON (fams.BARCODE = fam.BARCODE AND fams.ID_HEADER = fam.ID)
			left JOIN dbo.Ap_INVOICE_REGISTRATION_DETAIL aird ON (aird.INVOICE_CODE = airh.CODE_BARCODE AND aird.ITEM_CODE = fams.ITEM_CODE)
	WHERE fam.barcode = @barcode
			AND	  fam.PAID_STATUS = 'PAID'

	SET @total_asset_maintenance = ISNULL(@amount_maintenance,0) + ISNULL(@amount_maintenance_aip,0)
	
	select	fa.id
			,fa.ast_code
			,fa.AST_NAME + ' - ' + mu.DESCRIPTION'ast_name'
			,fa.cat_code
			,fa.trans_flag_code
			,fa.date_purc
			,fa.cost_price
			,fa.orig_price
			,fa.sale_value
			,fa.sale_date
			,fa.disposal_date
			,fa.branch_code
			,fa.tot_depre
			,fa.depre_period
			,fa.net_book_value
			,fa.remarks
			,fa.barcode
			,fcf.cat_name 'cat_code_fiscal'
			,fa.tot_depre_fiscal
			,fa.depre_period_fiscal
			,fa.net_book_value_fiscal
			,fa.residual_value
			,fa.object_info
			,sat.description 'asset_type_desc'
			,fa.asset_type
			,fa.pic_code
			,fa.fa_parent_code
			,fa.REQUESTOR
			,em.emp_name
			,fa.OLD_ASSETCODE 'OLD_BARCODE'
			--
			,fc.cat_name
			,msl.loc_name 
			,mb.description 'branch_name'
			,fa.current_branch
			--
			,fg.name 'cat_code_book' -- johan 2015-10-09
			,fa.requestor
			,emp.emp_name
			,fa.supplier_code
			,ms.supplier_name
			,fa1.BARCODE + ' - ' + fa1.ast_name 'fa_parent_name'
			,poh.CODE
			,@total_asset_maintenance 'maintenance'
			,isnull(@staff_name,'-') 'used_by' -- (+) Ari 21-01-2023 ket : get item is used, enhancement 2023
			,isnull(concat(@grouping_asset_id,' - ',@grouping_asset_name),'-') 'grouping_asset_name' -- Iproc Phase III
	from	fa_asset fa
			left join fa_category fc on (fa.cat_code = fc.cat_code)
			left join dbo.fa_location msl on (msl.loc_code = fa.current_branch )
			left join dbo.fa_category_fiscal fcf on (fcf.cat_code  = fa.cat_code_fiscal)
			left join dbo.fa_group fg on (fg.code = fa.cat_code_book)  -- johan 2015-10-09
			left join dbo.sys_asset_type sat on (sat.code = fa.asset_type)
			left join dbo.employee_main em on (em.emp_code = fa.pic_code)
			left join dbo.master_branch mb on (fa.branch_code = mb.code)
			left join dbo.employee_main emp on (fa.requestor = em.emp_code)
			left join dbo.master_supplier ms on (fa.supplier_code = ms.supplier_code) 
			left join fa_asset fa1 on (fa1.barcode = fa.fa_parent_code)
			LEFT JOIN dbo.PURCHASE_ORDER_HEADER poh ON (poh.CODE_BARCODE = fa.PO_CODE)
			INNER JOIN dbo.MASTER_ITEM mi ON (mi.ITEM_CODE = fa.AST_CODE)
			INNER JOIN dbo.MASTER_UNITS mu ON (mu.CODE = mi.OWNER)
	where	fa.id = @p_id
	
end

GO


