CREATE PROCEDURE [dbo].[xsp_fa_grouping_asset_deactivate_if_empty]
(
    @p_source_type      nvarchar(20),
    @p_code_barcode     nvarchar(50),
    @p_mod_by           nvarchar(50),
    @p_mod_date         datetime,
    @p_mod_ip_address   nvarchar(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @affected_ga_codes TABLE (
        fa_ga_code nvarchar(40) PRIMARY KEY
    );

    IF @p_source_type = 'SALE'
    BEGIN
        INSERT INTO @affected_ga_codes (fa_ga_code)
        SELECT DISTINCT fad.FA_GA_CODE
        FROM dbo.fa_sale_detail fsd WITH (NOLOCK)
        INNER JOIN dbo.FA_GROUPING_ASSET_DETAIL fad WITH (NOLOCK)
            ON fsd.BARCODE = fad.BARCODE
        INNER JOIN dbo.FA_GROUPING_ASSET fga WITH (NOLOCK)
            ON fga.FA_GROUP_ASSET_CODE = fad.FA_GA_CODE
        WHERE fsd.fa_sale_code = @p_code_barcode
          AND fga.IS_ACTIVE = 1;
    END

    IF @p_source_type = 'DISPOSAL'
    BEGIN
        INSERT INTO @affected_ga_codes (fa_ga_code)
        SELECT DISTINCT fad.FA_GA_CODE
        FROM dbo.fa_disposal_detail fdd WITH (NOLOCK)
        INNER JOIN dbo.FA_GROUPING_ASSET_DETAIL fad WITH (NOLOCK)
            ON fdd.BARCODE = fad.BARCODE
        INNER JOIN dbo.FA_GROUPING_ASSET fga WITH (NOLOCK)
            ON fga.FA_GROUP_ASSET_CODE = fad.FA_GA_CODE
        WHERE fdd.fa_disposal_code = @p_code_barcode
          AND fga.IS_ACTIVE = 1;
    END

    IF @p_source_type = 'MUTATION'
    BEGIN
        INSERT INTO @affected_ga_codes (fa_ga_code)
        SELECT DISTINCT fad.FA_GA_CODE
        FROM dbo.fa_request_mutation_detail frmd WITH (NOLOCK)
        INNER JOIN dbo.FA_GROUPING_ASSET_DETAIL fad WITH (NOLOCK)
            ON frmd.ITEM_CODE = fad.BARCODE
        INNER JOIN dbo.FA_GROUPING_ASSET fga WITH (NOLOCK)
            ON fga.FA_GROUP_ASSET_CODE = fad.FA_GA_CODE
        WHERE frmd.IR_CODE = @p_code_barcode
          AND fga.IS_ACTIVE = 1;
    END

    UPDATE gad
    SET gad.IS_ACTIVE = 0,
        gad.MOD_DATE = @p_mod_date,
        gad.MOD_BY = @p_mod_by,
        gad.MOD_IP_ADDRESS = @p_mod_ip_address
    FROM dbo.FA_GROUPING_ASSET_DETAIL gad
    INNER JOIN @affected_ga_codes a
        ON a.fa_ga_code = gad.FA_GA_CODE
    WHERE gad.IS_ACTIVE = 1
      AND ISNULL(gad.FA_ASSET_ID, 0) = 0
      AND gad.IS_PARENT = 1
      AND NOT EXISTS (
            SELECT 1
            FROM dbo.FA_GROUPING_ASSET_DETAIL active_real
            WHERE active_real.FA_GA_CODE = gad.FA_GA_CODE
              AND active_real.IS_ACTIVE = 1
              AND ISNULL(active_real.FA_ASSET_ID, 0) <> 0
      );

    UPDATE fga
    SET fga.IS_ACTIVE = 0,
        fga.MOD_DATE = @p_mod_date,
        fga.MOD_BY = @p_mod_by,
        fga.MOD_IP_ADDRESS = @p_mod_ip_address
    FROM dbo.FA_GROUPING_ASSET fga
    INNER JOIN @affected_ga_codes a
        ON a.fa_ga_code = fga.FA_GROUP_ASSET_CODE
    WHERE fga.IS_ACTIVE = 1
      AND NOT EXISTS (
            SELECT 1
            FROM dbo.FA_GROUPING_ASSET_DETAIL active_real
            WHERE active_real.FA_GA_CODE = fga.FA_GROUP_ASSET_CODE
              AND active_real.IS_ACTIVE = 1
              AND ISNULL(active_real.FA_ASSET_ID, 0) <> 0
      );
END
GO
