CREATE PROCEDURE [dbo].[xsp_fa_grouping_asset_detail_getrows]
(
    @p_keywords             NVARCHAR(50),
    @p_fa_group_asset_code  NVARCHAR(18)
)
AS
BEGIN
    SET NOCOUNT ON;

    SET @p_keywords = LTRIM(RTRIM(ISNULL(@p_keywords, '')));
    SELECT  
        fgad.id,
        fgad.barcode        AS 'barcode',
        fgad.name_asset     AS 'item_name',
        fc.cat_name         AS 'category',
        fgad.description,
        fgad.fa_ga_code,
        fgad.code_asset,
        fgad.name_asset,
        mu.DESCRIPTION      AS 'OWNER',
        em.emp_name         AS 'mod_by',
        fgad.MOD_DATE,
        fgad.is_parent,
        fgad.is_active 
    FROM dbo.fa_grouping_asset_detail fgad WITH (NOLOCK)
    INNER JOIN dbo.fa_asset fa WITH (NOLOCK) 
        ON fgad.code_asset = fa.ast_code 
       AND fgad.FA_ASSET_ID = fa.id 
       AND fgad.barcode = fa.barcode
    LEFT JOIN dbo.fa_category fc WITH (NOLOCK) 
        ON fc.cat_code = fa.cat_code 
    INNER JOIN dbo.MASTER_ITEM mi WITH (NOLOCK) 
        ON mi.ITEM_CODE = fa.AST_CODE
    INNER JOIN dbo.master_units mu WITH (NOLOCK) 
        ON mi.owner = mu.code 
       AND mu.IS_ACTIVE = 1 
       AND mu.IS_OWNER = 1
    LEFT JOIN dbo.employee_main em WITH (NOLOCK) 
        ON fgad.mod_by = em.emp_code
    WHERE fgad.is_active = 1
      AND fgad.fa_ga_code = @p_fa_group_asset_code
      -- Optimasi Index: Jika keywords kosong, bypass LIKE operation
      AND (
            @p_keywords = '' 
            OR fgad.code_asset LIKE '%' + @p_keywords + '%'
            OR fgad.name_asset LIKE '%' + @p_keywords + '%'
            OR fgad.barcode    LIKE '%' + @p_keywords + '%'
			OR fc.cat_name	   LIKE '%' + @p_keywords + '%'
			OR mu.DESCRIPTION  LIKE '%' + @p_keywords + '%'
			OR em.emp_name     LIKE '%' + @p_keywords + '%'
          )

    UNION ALL 
    SELECT  
        fgad.id,
        fgad.barcode        AS 'barcode',
        fgad.name_asset     AS 'item_name',
        '-'                 AS 'category',
        fgad.description,
        fgad.fa_ga_code,
        fgad.code_asset,
        fgad.name_asset,
        mu.DESCRIPTION      AS 'OWNER',
        em.emp_name         AS 'mod_by',
        fgad.MOD_DATE,
        fgad.is_parent,
        fgad.is_active 
    FROM dbo.fa_grouping_asset_detail fgad WITH (NOLOCK)
    INNER JOIN dbo.inventory_barcode ib WITH (NOLOCK) 
        ON fgad.barcode = ib.barcode
    INNER JOIN dbo.MASTER_ITEM mi WITH (NOLOCK) 
        ON mi.ITEM_CODE = ib.ITEM_CODE
    INNER JOIN dbo.master_units mu WITH (NOLOCK) 
        ON mi.owner = mu.code 
       AND mu.IS_ACTIVE = 1 
       AND mu.IS_OWNER = 1
    LEFT JOIN dbo.employee_main em WITH (NOLOCK) 
        ON fgad.mod_by = em.emp_code
    WHERE fgad.is_active = 1
      AND fgad.fa_ga_code = @p_fa_group_asset_code
      AND (
            @p_keywords = '' 
            OR fgad.code_asset LIKE '%' + @p_keywords + '%'
            OR fgad.name_asset LIKE '%' + @p_keywords + '%'
            OR fgad.barcode    LIKE '%' + @p_keywords + '%'
			OR mu.DESCRIPTION  LIKE '%' + @p_keywords + '%'
			OR em.emp_name     LIKE '%' + @p_keywords + '%'
          )
          
    ORDER BY fgad.is_parent DESC;
END
GO


