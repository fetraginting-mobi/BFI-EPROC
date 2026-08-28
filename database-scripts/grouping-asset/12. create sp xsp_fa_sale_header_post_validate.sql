CREATE PROCEDURE [dbo].[xsp_fa_sale_header_post_validate]
(
    @p_code_barcode     NVARCHAR(14),
    @p_mod_by           NVARCHAR(15) = NULL,
    @p_mod_date         DATETIME = NULL,
    @p_mod_ip_address   NVARCHAR(15) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @missing_asset NVARCHAR(MAX);
    DECLARE @invalid_child_assets NVARCHAR(MAX);

    -- 1. Buat Tabel Temporer
    CREATE TABLE #TEMPASSETSALE (
        CODE_ASSET      NVARCHAR(36),
        BARCODE         NVARCHAR(50),
        FA_SALE_CODE    NVARCHAR(28),
        FA_GA_CODE      NVARCHAR(48),
        IS_PARENT       BIT
    );

    CREATE TABLE #TEMPASSETGROUPING (
        CODE_ASSET      NVARCHAR(36),
        BARCODE         NVARCHAR(50),
        FA_GA_CODE      NVARCHAR(48),
        FA_ASSET_ID     INT,
        IS_PARENT       BIT
    );

    -- 2. Populate Data Penjualan Aset ke #TEMPASSETSALE
    INSERT INTO #TEMPASSETSALE (CODE_ASSET, BARCODE, FA_SALE_CODE, FA_GA_CODE, IS_PARENT)
    SELECT 
        fsd.CODE_ASSET,
        fsd.BARCODE,
        fsd.FA_SALE_CODE,
        ISNULL(fgad.FA_GA_CODE, ''),
        ISNULL(fgad.IS_PARENT, 0)
    FROM dbo.FA_SALE_DETAIL fsd WITH (NOLOCK)
    LEFT JOIN dbo.fa_grouping_asset_detail fgad WITH (NOLOCK)
        ON fgad.BARCODE = fsd.BARCODE 
       AND fgad.CODE_ASSET = fsd.CODE_ASSET 
       AND fgad.IS_ACTIVE = 1
    WHERE fsd.FA_SALE_CODE = @p_code_barcode;

    -- 3. Populate Data Seluruh Anggota Group ke #TEMPASSETGROUPING
    IF EXISTS (SELECT 1 FROM #TEMPASSETSALE WHERE FA_GA_CODE <> '')
    BEGIN
        INSERT INTO #TEMPASSETGROUPING (CODE_ASSET, BARCODE, FA_GA_CODE, FA_ASSET_ID, IS_PARENT)
        SELECT 
            fgad.CODE_ASSET,
            fgad.BARCODE,
            fgad.FA_GA_CODE,
            fgad.FA_ASSET_ID,
            ISNULL(fgad.IS_PARENT, 0)
        FROM dbo.fa_grouping_asset_detail fgad WITH (NOLOCK)
        INNER JOIN (SELECT DISTINCT FA_GA_CODE FROM #TEMPASSETSALE WHERE FA_GA_CODE <> '') temp 
            ON fgad.FA_GA_CODE = temp.FA_GA_CODE 
           AND fgad.IS_ACTIVE = 1;
    END
		
	-- is parent = 1 and fa_asset_id = 0 (Inventory)
	 IF EXISTS ( 
        SELECT 1 
        FROM #TEMPASSETGROUPING tag
        WHERE tag.IS_PARENT = 1  AND FA_ASSET_ID = 0
    )
    BEGIN
		select 'masuk inventory'
		SELECT @invalid_child_assets = STUFF((
			SELECT DISTINCT 
				'\n- Asset Code: ' + ISNULL(tag.CODE_ASSET, '-') 
				+ ' (Barcode: ' + ISNULL(tag.BARCODE, '-') + ')'
				+ ' is linked in Group: ' + ISNULL(tag.FA_GA_CODE, '-')
			FROM #TEMPASSETGROUPING tag 
			WHERE tag.BARCODE not in (select barcode from #TEMPASSETSALE) 
				  AND FA_ASSET_ID <> 0
           
			FOR XML PATH(''), TYPE
		).value('.', 'NVARCHAR(MAX)'), 1, 2, '');
		IF ISNULL(@invalid_child_assets, '') <> ''
		BEGIN
			DROP TABLE #TEMPASSETSALE;
			DROP TABLE #TEMPASSETGROUPING;
			SET @ErrorMessage = 'missing asset(s):\n' 
								+ @invalid_child_assets;
			RAISERROR (@ErrorMessage, 16, 1);
			RETURN;
		END 
	END

    -- IS_PARENT = 1 AND FA_ASSET_ID <> 0)
    IF EXISTS (
        SELECT 1 
        FROM #TEMPASSETGROUPING tag
		inner join  #TEMPASSETSALE tas on tag.BARCODE = tas.BARCODE and tag.CODE_ASSET = tas.CODE_ASSET
        WHERE tag.IS_PARENT = 1  AND FA_ASSET_ID <> 0
    )
    BEGIN
        SELECT @missing_asset = STUFF((
            SELECT DISTINCT
                '\nBarcode: ' + ISNULL(tag.BARCODE, '-')
                + ' / Group Id: ' + ISNULL(tag.FA_GA_CODE, '-') + ','
            FROM #TEMPASSETGROUPING tag
            LEFT JOIN #TEMPASSETSALE tas
                ON tas.FA_GA_CODE = tag.FA_GA_CODE
               AND LTRIM(RTRIM(tas.BARCODE)) = LTRIM(RTRIM(tag.BARCODE))
            WHERE tas.BARCODE IS NULL
              AND ISNULL(tag.FA_ASSET_ID, 0) <> 0
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 2, '');

        IF ISNULL(@missing_asset, '') <> ''
        BEGIN
            IF RIGHT(@missing_asset, 1) = ','
            BEGIN
                SET @missing_asset = SUBSTRING(@missing_asset, 1, LEN(@missing_asset) - 1) + ' -';
            END

            DROP TABLE #TEMPASSETSALE;
            DROP TABLE #TEMPASSETGROUPING;

            SET @ErrorMessage = '\n- This transaction cannot be processed because the asset is still linked to another asset within the same group.' + '\n' +
                                'Please remove it from the group first, or add all assets within the group.' + '\n\n' +
                                'Missing asset:\n' + @missing_asset;
            RAISERROR (@ErrorMessage, 16, 1);
            RETURN;
        END
    END

	-- IS_PARENT = 0 AND FA_ASSET_ID <> 0)
	IF EXISTS (
        SELECT 1 
        FROM #TEMPASSETSALE tas 
		inner join #TEMPASSETGROUPING tag on tag.BARCODE = tas.BARCODE and tag.CODE_ASSET = tas.CODE_ASSET
        WHERE tas.IS_PARENT = 0  AND tas.fa_ga_code <> '' and tag.IS_PARENT = 0
    )
    BEGIN
		SELECT @invalid_child_assets = STUFF((
			SELECT DISTINCT 
				' (Barcode: ' + ISNULL(tag.BARCODE, '-') + ')'
				+ ' n in Grouping Asset: ' + ISNULL(tag.FA_GA_CODE, '-')
			FROM #TEMPASSETSALE tag 
			WHERE tag.BARCODE in (select barcode from #TEMPASSETGROUPING where is_parent = 0)            
			FOR XML PATH(''), TYPE
		).value('.', 'NVARCHAR(MAX)'), 1, 2, '');
		IF ISNULL(@invalid_child_assets, '') <> ''
		BEGIN
			DROP TABLE #TEMPASSETSALE;
			DROP TABLE #TEMPASSETGROUPING;
			SET @ErrorMessage = 'please remove :\n ' 
								+ @invalid_child_assets;
			RAISERROR (@ErrorMessage, 16, 1);
			RETURN;
		END 
	END
END