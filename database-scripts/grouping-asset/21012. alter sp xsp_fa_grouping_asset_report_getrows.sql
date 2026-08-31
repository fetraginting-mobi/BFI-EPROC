ALTER procedure [dbo].[xsp_fa_grouping_asset_report_getrows]
(
	@p_branch_code nvarchar(20), 
	@p_location_code nvarchar(20)='ALL',
	@p_category nvarchar(20) ='ALL'
)as
begin			
	if object_id('tempdb..#basedata') is not null drop table #basedata
	select
		fagd.fa_ga_code,
		fagd.barcode,
		fag.branch_code,
		mi.group_code,
		aird.purchase_amount,
		fa.trans_flag_code,
		fagd.is_parent
	into #basedata
	from fa_grouping_asset_detail fagd with (nolock)
	inner join fa_grouping_asset fag with (nolock) on fag.fa_group_asset_code = fagd.fa_ga_code 
	inner join fa_asset fa with (nolock) on fagd.barcode = fa.barcode
	inner join master_item mi with (nolock) on fagd.code_asset = mi.item_code and fa.ast_code = mi.item_code
	left join purchase_order_detail pod with (nolock) on fa.po_detail_id = pod.id and fa.po_code = pod.po_code
	left join ap_invoice_registration_detail aird with (nolock) on pod.invoice_no = aird.invoice_code and pod.invoice_detail_id = aird.id
	where fagd.is_active = 1
	and (fag.branch_code = @p_branch_code or @p_branch_code = 'all')
	and (fag.fa_location = @p_location_code or @p_location_code = 'all');

	CREATE CLUSTERED INDEX IX_Temp_Group ON #BaseData (FA_GA_CODE, IS_PARENT);
	declare 
		@generate_date datetime =getdate();

	WITH FlattenedData AS (
		SELECT 
			ROW_NUMBER() OVER (PARTITION BY p.FA_GA_CODE ORDER BY c.BARCODE) AS RN,
			p.FA_GA_CODE,
			p.BARCODE AS AssetCodeInduk,
			p.BRANCH_CODE AS CostCenterInduk,
			p.group_code AS CategoryCodeInduk,
			p.PURCHASE_AMOUNT AS PriceInduk,
			p.TRANS_FLAG_CODE AS StatusInduk,
			c.BARCODE AS AssetCodeTerikat,
			c.TRANS_FLAG_CODE AS StatusTerikat,
			c.group_code AS CategoryCodeTerikat,
			c.PURCHASE_AMOUNT AS PriceTerikat,
			getdate() as GENERATED_DATE
		FROM #BaseData p
		LEFT JOIN #BaseData c ON p.FA_GA_CODE = c.FA_GA_CODE AND c.IS_PARENT = 0
		WHERE p.IS_PARENT = 1
	)

	-- 3. Final Query dengan Rollup & Visual Logic
	SELECT 
		CASE WHEN GROUPING(AssetCodeTerikat) = 1 THEN DENSE_RANK() OVER (ORDER BY FA_GA_CODE) ELSE NULL END AS No,    
		CASE WHEN GROUPING(AssetCodeTerikat) = 1 THEN 'Total Asset Value' 
				WHEN RN = 1 THEN CAST(FA_GA_CODE AS VARCHAR) ELSE '' END AS [Group Code],         
		CASE WHEN RN = 1 AND GROUPING(AssetCodeTerikat) = 0 THEN AssetCodeInduk ELSE NULL END AS 'Parent Asset Code',
		CASE WHEN RN = 1 AND GROUPING(AssetCodeTerikat) = 0 THEN CostCenterInduk ELSE NULL END AS 'Parent Branch Code',
		CASE WHEN RN = 1 AND GROUPING(AssetCodeTerikat) = 0 THEN CategoryCodeInduk ELSE NULL END AS 'Parent Category Code',    
		CASE WHEN (RN = 1 AND GROUPING(AssetCodeTerikat) = 0) OR GROUPING (AssetCodeTerikat) = 1 
				THEN MAX(PriceInduk) ELSE NULL END AS 'Parent Purchase Price',         
		CASE WHEN RN = 1 AND GROUPING(AssetCodeTerikat) = 0 THEN StatusInduk ELSE NULL END AS 'Parent Asset Status',    
		AssetCodeTerikat 'Child Asset Code',
		StatusTerikat 'Child Asset Status',
		CategoryCodeTerikat AS 'Child Category Code',
		PriceTerikat AS 'Child Purchase Price', 
		CASE WHEN GROUPING(AssetCodeTerikat) = 1 THEN SUM(ISNULL(PriceTerikat, 0)) 
				ELSE PriceTerikat END 'Total Child Assets Value'--,
		--@generate_date 'Generated Date'
	FROM FlattenedData
	GROUP BY ROLLUP (FA_GA_CODE, (AssetCodeInduk, CostCenterInduk, CategoryCodeInduk, PriceInduk, StatusInduk, AssetCodeTerikat, StatusTerikat, CategoryCodeTerikat, PriceTerikat, RN,GENERATED_DATE))
	HAVING FA_GA_CODE IS NOT NULL 
		AND (GROUPING(AssetCodeTerikat) = 1 OR AssetCodeTerikat IS NOT NULL OR RN = 1)
	ORDER BY FA_GA_CODE, GROUPING(AssetCodeTerikat), RN;
end
GO


