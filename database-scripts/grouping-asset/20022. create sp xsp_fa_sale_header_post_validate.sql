CREATE PROCEDURE [dbo].[xsp_fa_sale_header_post_validate]
(
    @p_code_barcode     NVARCHAR(14)
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ErrorMessage NVARCHAR(MAX)
			,@missing_asset NVARCHAR(MAX)
			,@invalid_child_assets NVARCHAR(MAX)
			,@other_transaction NVARCHAR(MAX);

    -- 1. Buat Tabel Temporer
	--drop table #TEMPASSETSALE
    CREATE TABLE #TEMPASSETSALE (
        CODE_ASSET      NVARCHAR(36),
        BARCODE         NVARCHAR(50),
        FA_SALE_CODE    NVARCHAR(28),
        FA_GA_CODE      NVARCHAR(48),
        IS_PARENT       BIT
    );
	--drop table #TEMPTRANSACTION
	CREATE TABLE #TEMPTRANSACTION (
        CODE_ASSET      NVARCHAR(36),
        BARCODE         NVARCHAR(50),
        TRANS_CODE		NVARCHAR(28),
        TRANS_STATUS    NVARCHAR(48),
        [TRANSACTION]   NVARCHAR(48)
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
    
	--insert data  #TEMPTRANSACTION
	insert into #TEMPTRANSACTION
	SELECT 
		tas.CODE_ASSET,
		tas.BARCODE,
		t.TRANS_CODE,
		t.TRANS_STATUS,
		t.[TRANSACTION]
	FROM #TEMPASSETSALE tas
	INNER JOIN FA_ASSET fa WITH (NOLOCK) 
		ON fa.BARCODE = tas.BARCODE 
	   AND fa.TRANS_FLAG_CODE = 'AVAILABLE'
	CROSS APPLY (
		SELECT 
			frmh.CODE AS TRANS_CODE,
			frmh.TRANS_FLAG_CODE AS TRANS_STATUS,
			'MUTATION' AS [TRANSACTION]
		FROM FA_REQUEST_MUTATION_DETAIL frmd WITH (NOLOCK)
		INNER JOIN FA_REQUEST_MUTATION_HEADER frmh WITH (NOLOCK) 
			ON frmd.IR_CODE = frmh.CODE_BARCODE
		WHERE frmd.ITEM_CODE = tas.BARCODE
		  AND frmh.TRANS_FLAG_CODE IN ('NEW', 'PENDING')

		UNION 
		SELECT 
			fsh.CODE AS TRANS_CODE,
			fsh.TRANS_FLAG_CODE AS TRANS_STATUS,
			'SALE' AS [TRANSACTION]
		FROM FA_SALE_DETAIL fsd WITH (NOLOCK)
		INNER JOIN FA_SALE_HEADER fsh WITH (NOLOCK) 
			ON fsd.FA_SALE_CODE = fsh.CODE_BARCODE
		WHERE fsd.BARCODE = tas.BARCODE
		  AND fsd.FA_SALE_CODE <> @p_code_barcode
		  AND fsh.TRANS_FLAG_CODE IN ('NEW', 'ONPROGRESS')

		UNION
		SELECT 
			fdh.CODE AS TRANS_CODE,
			fdh.TRANS_FLAG_CODE AS TRANS_STATUS,
			'DISPOSAL' AS [TRANSACTION]
		FROM FA_DISPOSAL_DETAIL fdd WITH (NOLOCK)
		INNER JOIN FA_DISPOSAL_HEADER fdh WITH (NOLOCK) 
			ON fdd.FA_DISPOSAL_CODE = fdh.CODE_BARCODE
		WHERE fdd.BARCODE = tas.BARCODE
		  AND fdh.TRANS_FLAG_CODE IN ('NEW', 'ONPROGRESS')
	) t
	order by t.TRANS_CODE

	IF EXISTS (select 1 from #TEMPTRANSACTION)
	BEGIN
		SELECT @other_transaction = STUFF((
			SELECT DISTINCT 
				' ( Asset Barcode: ' + transc.BARCODE+ ')'
				+ ' is on transaction ' + transc.[TRANSACTION]
				+ ' : ' + transc.TRANS_CODE
			FROM #TEMPTRANSACTION transc 
           
			FOR XML PATH(''), TYPE
		).value('.', 'NVARCHAR(MAX)'), 1, 2, '');
		IF ISNULL(@other_transaction, '') <> ''
		BEGIN
			DROP TABLE #TEMPASSETSALE;
			DROP TABLE #TEMPTRANSACTION;
			SET @ErrorMessage = @other_transaction;
			RAISERROR (@ErrorMessage, 16, 1);
			RETURN;
		END 		
	END
			
	CREATE TABLE #TEMPASSETGROUPING (
        CODE_ASSET      NVARCHAR(36),
        BARCODE         NVARCHAR(50),
        FA_GA_CODE      NVARCHAR(48),
        FA_ASSET_ID     INT,
        IS_PARENT       BIT
    );

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
		INNER JOIN #TEMPASSETGROUPING tag 
			ON tag.BARCODE = tas.BARCODE AND tag.CODE_ASSET = tas.CODE_ASSET
		WHERE tas.IS_PARENT = 0 
		  AND tas.FA_GA_CODE <> '' 
		  AND tag.IS_PARENT = 0
		)
		BEGIN
			SELECT @invalid_child_assets = STUFF((
				SELECT DISTINCT 
					'\n- Barcode: ' + ISNULL(tag.BARCODE, '-') 
					+ ' is missing from Grouping Asset: ' + ISNULL(tag.FA_GA_CODE, '-')
				FROM #TEMPASSETGROUPING tag
				LEFT JOIN #TEMPASSETSALE tam 
					ON tam.FA_GA_CODE = tag.FA_GA_CODE 
				   AND LTRIM(RTRIM(tam.BARCODE)) = LTRIM(RTRIM(tag.BARCODE))
				WHERE tam.BARCODE IS NULL 
				  AND ISNULL(tag.FA_ASSET_ID, 0) <> 0 
				  AND tag.FA_GA_CODE IN (
					  SELECT DISTINCT FA_GA_CODE FROM #TEMPASSETSALE WHERE FA_GA_CODE <> ''
				  )
				FOR XML PATH(''), TYPE
			).value('.', 'NVARCHAR(MAX)'), 1, 2, '');

			IF ISNULL(@invalid_child_assets, '') <> ''
			BEGIN
				DROP TABLE #TEMPASSETSALE;
				DROP TABLE #TEMPASSETGROUPING;

				SET @ErrorMessage = 'Please remove the asset from the group first or include all group assets:\n' 
									+ @invalid_child_assets;
				RAISERROR (@ErrorMessage, 16, 1);
				RETURN;
			END
		END
END