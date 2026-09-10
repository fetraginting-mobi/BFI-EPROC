CREATE PROCEDURE [dbo].[xsp_fa_request_mutation_header_post_upload_validate]
(
    @p_code_barcode NVARCHAR(50)
)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(MAX)
           ,@missing_asset NVARCHAR(MAX)
           ,@invalid_child_assets NVARCHAR(MAX)
           ,@other_transaction NVARCHAR(MAX);

    CREATE TABLE #TEMPASSETMUTATION
    (
        CODE_ASSET NVARCHAR(36),
        BARCODE NVARCHAR(50),
        IR_CODE NVARCHAR(28),
        FA_GA_CODE NVARCHAR(48),
        FA_ASSET_ID INT,
        IS_PARENT BIT
    );

    CREATE TABLE #TEMPTRANSACTION
    (
        CODE_ASSET NVARCHAR(36),
        BARCODE NVARCHAR(50),
        TRANS_CODE NVARCHAR(28),
        TRANS_STATUS NVARCHAR(48),
        [TRANSACTION] NVARCHAR(48)
    );

    INSERT INTO #TEMPASSETMUTATION
    (
        CODE_ASSET,
        BARCODE,
        IR_CODE,
        FA_GA_CODE,
        FA_ASSET_ID,
        IS_PARENT
    )
    SELECT
        fa.AST_CODE,
        frmd.ITEM_CODE,
        frmd.IR_CODE,
        ISNULL(fgad.FA_GA_CODE, ''),
        ISNULL(fgad.FA_ASSET_ID, 0),
        ISNULL(fgad.IS_PARENT, 0)
    FROM dbo.FA_REQUEST_MUTATION_DETAIL frmd WITH (NOLOCK)
    LEFT JOIN dbo.FA_ASSET fa WITH (NOLOCK)
        ON frmd.ITEM_CODE = fa.BARCODE
    LEFT JOIN dbo.FA_GROUPING_ASSET_DETAIL fgad WITH (NOLOCK)
        ON fgad.BARCODE = frmd.ITEM_CODE
       AND fgad.CODE_ASSET = fa.AST_CODE
       AND fgad.IS_ACTIVE = 1
    WHERE frmd.IR_CODE = @p_code_barcode;

    INSERT INTO #TEMPTRANSACTION
    (
        CODE_ASSET,
        BARCODE,
        TRANS_CODE,
        TRANS_STATUS,
        [TRANSACTION]
    )
    SELECT
        tas.CODE_ASSET,
        tas.BARCODE,
        t.TRANS_CODE,
        t.TRANS_STATUS,
        t.[TRANSACTION]
    FROM #TEMPASSETMUTATION tas
    INNER JOIN dbo.FA_ASSET fa WITH (NOLOCK)
        ON fa.BARCODE = tas.BARCODE
       AND fa.TRANS_FLAG_CODE = 'AVAILABLE'
    CROSS APPLY
    (
        SELECT
            frmh.CODE AS TRANS_CODE,
            frmh.TRANS_FLAG_CODE AS TRANS_STATUS,
            'MUTATION' AS [TRANSACTION]
        FROM dbo.FA_REQUEST_MUTATION_DETAIL frmd WITH (NOLOCK)
        INNER JOIN dbo.FA_REQUEST_MUTATION_HEADER frmh WITH (NOLOCK)
            ON frmd.IR_CODE = frmh.CODE_BARCODE
        WHERE frmd.ITEM_CODE = tas.BARCODE
          AND frmh.CODE_BARCODE <> @p_code_barcode
          AND frmh.TRANS_FLAG_CODE IN ('NEW', 'PENDING')

        UNION

        SELECT
            fsh.CODE AS TRANS_CODE,
            fsh.TRANS_FLAG_CODE AS TRANS_STATUS,
            'SALE' AS [TRANSACTION]
        FROM dbo.FA_SALE_DETAIL fsd WITH (NOLOCK)
        INNER JOIN dbo.FA_SALE_HEADER fsh WITH (NOLOCK)
            ON fsd.FA_SALE_CODE = fsh.CODE_BARCODE
        WHERE fsd.BARCODE = tas.BARCODE
          AND fsh.TRANS_FLAG_CODE IN ('NEW', 'ONPROGRESS')

        UNION

        SELECT
            fdh.CODE AS TRANS_CODE,
            fdh.TRANS_FLAG_CODE AS TRANS_STATUS,
            'DISPOSAL' AS [TRANSACTION]
        FROM dbo.FA_DISPOSAL_DETAIL fdd WITH (NOLOCK)
        INNER JOIN dbo.FA_DISPOSAL_HEADER fdh WITH (NOLOCK)
            ON fdd.FA_DISPOSAL_CODE = fdh.CODE_BARCODE
        WHERE fdd.BARCODE = tas.BARCODE
          AND fdh.TRANS_FLAG_CODE IN ('NEW', 'ONPROGRESS')
    ) t;

    IF EXISTS (SELECT 1 FROM #TEMPTRANSACTION)
    BEGIN
        SELECT @other_transaction = STUFF((
            SELECT DISTINCT
                CHAR(10) + '- Asset Barcode: ' + ISNULL(transc.BARCODE, '-')
                + ' is on transaction ' + ISNULL(transc.[TRANSACTION], '-')
                + ' : ' + ISNULL(transc.TRANS_CODE, '-')
            FROM #TEMPTRANSACTION transc
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

        IF ISNULL(@other_transaction, '') <> ''
        BEGIN
            RAISERROR (@other_transaction, 16, 1);
            RETURN;
        END
    END

    CREATE TABLE #TEMPASSETGROUPING
    (
        CODE_ASSET NVARCHAR(36),
        BARCODE NVARCHAR(50),
        FA_GA_CODE NVARCHAR(48),
        FA_ASSET_ID INT,
        IS_PARENT BIT
    );

    IF EXISTS (SELECT 1 FROM #TEMPASSETMUTATION WHERE FA_GA_CODE <> '')
    BEGIN
        INSERT INTO #TEMPASSETGROUPING
        (
            CODE_ASSET,
            BARCODE,
            FA_GA_CODE,
            FA_ASSET_ID,
            IS_PARENT
        )
        SELECT
            fgad.CODE_ASSET,
            fgad.BARCODE,
            fgad.FA_GA_CODE,
            fgad.FA_ASSET_ID,
            ISNULL(fgad.IS_PARENT, 0)
        FROM dbo.FA_GROUPING_ASSET_DETAIL fgad WITH (NOLOCK)
        INNER JOIN
        (
            SELECT DISTINCT FA_GA_CODE
            FROM #TEMPASSETMUTATION
            WHERE FA_GA_CODE <> ''
        ) temp
            ON fgad.FA_GA_CODE = temp.FA_GA_CODE
           AND fgad.IS_ACTIVE = 1;
    END

    IF EXISTS
    (
        SELECT 1
        FROM #TEMPASSETGROUPING tag
        WHERE tag.IS_PARENT = 1
          AND tag.FA_ASSET_ID = 0
    )
    BEGIN
        SELECT @invalid_child_assets = STUFF((
            SELECT DISTINCT
                CHAR(10) + '- Asset Code: ' + ISNULL(tag.CODE_ASSET, '-')
                + ' (Barcode: ' + ISNULL(tag.BARCODE, '-') + ')'
                + ' is linked in Group: ' + ISNULL(tag.FA_GA_CODE, '-')
            FROM #TEMPASSETGROUPING tag
            WHERE tag.BARCODE NOT IN (SELECT barcode FROM #TEMPASSETMUTATION)
              AND tag.FA_ASSET_ID <> 0
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

        IF ISNULL(@invalid_child_assets, '') <> ''
        BEGIN
            SET @ErrorMessage = 'missing asset(s):' + CHAR(10) + @invalid_child_assets;
            RAISERROR (@ErrorMessage, 16, 1);
            RETURN;
        END
    END

    IF EXISTS
    (
        SELECT 1
        FROM #TEMPASSETGROUPING tag
        INNER JOIN #TEMPASSETMUTATION tas
            ON tag.BARCODE = tas.BARCODE
           AND tag.CODE_ASSET = tas.CODE_ASSET
        WHERE tag.IS_PARENT = 1
          AND tag.FA_ASSET_ID <> 0
    )
    BEGIN
        SELECT @missing_asset = STUFF((
            SELECT DISTINCT
                CHAR(10) + '- Barcode: ' + ISNULL(tag.BARCODE, '-')
                + ' / Group Id: ' + ISNULL(tag.FA_GA_CODE, '-')
            FROM #TEMPASSETGROUPING tag
            LEFT JOIN #TEMPASSETMUTATION tas
                ON tas.FA_GA_CODE = tag.FA_GA_CODE
               AND LTRIM(RTRIM(tas.BARCODE)) = LTRIM(RTRIM(tag.BARCODE))
            WHERE tas.BARCODE IS NULL
              AND ISNULL(tag.FA_ASSET_ID, 0) <> 0
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

        IF ISNULL(@missing_asset, '') <> ''
        BEGIN
            SET @ErrorMessage = 'This transaction cannot be processed because the asset is still linked to another asset within the same group.'
                              + CHAR(10) + 'Please remove it from the group first, or add all assets within the group.'
                              + CHAR(10) + CHAR(10) + 'Missing asset:' + CHAR(10) + @missing_asset;
            RAISERROR (@ErrorMessage, 16, 1);
            RETURN;
        END
    END

    IF EXISTS
    (
        SELECT 1
        FROM #TEMPASSETMUTATION tas
        INNER JOIN #TEMPASSETGROUPING tag
            ON tag.BARCODE = tas.BARCODE
           AND tag.CODE_ASSET = tas.CODE_ASSET
        WHERE tas.IS_PARENT = 0
          AND tas.FA_GA_CODE <> ''
          AND tag.IS_PARENT = 0
    )
    BEGIN
        SELECT @invalid_child_assets = STUFF((
            SELECT DISTINCT
                CHAR(10) + '- Barcode: ' + ISNULL(tag.BARCODE, '-')
                + ' is missing from Grouping Asset: ' + ISNULL(tag.FA_GA_CODE, '-')
            FROM #TEMPASSETGROUPING tag
            LEFT JOIN #TEMPASSETMUTATION tam
                ON tam.FA_GA_CODE = tag.FA_GA_CODE
               AND LTRIM(RTRIM(tam.BARCODE)) = LTRIM(RTRIM(tag.BARCODE))
            WHERE tam.BARCODE IS NULL
              AND ISNULL(tag.FA_ASSET_ID, 0) <> 0
              AND tag.FA_GA_CODE IN
              (
                  SELECT DISTINCT FA_GA_CODE
                  FROM #TEMPASSETMUTATION
                  WHERE FA_GA_CODE <> ''
              )
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

        IF ISNULL(@invalid_child_assets, '') <> ''
        BEGIN
            SET @ErrorMessage = 'Please remove the asset from the group first or include all group assets:'
                              + CHAR(10) + @invalid_child_assets;
            RAISERROR (@ErrorMessage, 16, 1);
            RETURN;
        END
    END
END
GO
