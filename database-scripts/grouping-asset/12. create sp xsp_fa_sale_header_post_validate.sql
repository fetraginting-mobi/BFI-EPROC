CREATE OR ALTER PROCEDURE dbo.xsp_fa_sale_header_post_validate
(
    @p_code_barcode nvarchar(14),
    @p_mod_by nvarchar(15) = null,
    @p_mod_date datetime = null,
    @p_mod_ip_address nvarchar(15) = null
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @missing_asset nvarchar(max);
    DECLARE @ErrorMessage nvarchar(max);

    SELECT @missing_asset = STUFF((
        SELECT DISTINCT
               '\nBarcode: ' + ISNULL(fgad_child.barcode, '-')
               + ' / Group Id: ' + ISNULL(fgad_parent.fa_ga_code, '-') + ','
        FROM dbo.fa_sale_detail fsd_parent
        INNER JOIN dbo.fa_grouping_asset_detail fgad_parent
            ON LTRIM(RTRIM(fgad_parent.barcode)) = LTRIM(RTRIM(fsd_parent.barcode))
           AND ISNULL(fgad_parent.is_parent, 0) = 1
        INNER JOIN dbo.fa_grouping_asset_detail fgad_child
            ON fgad_child.fa_ga_code = fgad_parent.fa_ga_code and fgad_child.IS_ACTIVE = 1
        INNER JOIN FA_ASSET fa 
            ON fa.ID = fgad_child.FA_ASSET_ID 
           AND fa.AST_CODE = fgad_child.CODE_ASSET
        LEFT JOIN dbo.fa_sale_detail fsd_child
            ON fsd_child.fa_sale_code = fsd_parent.fa_sale_code
           AND LTRIM(RTRIM(fsd_child.barcode)) = LTRIM(RTRIM(fgad_child.barcode))
        WHERE fsd_parent.fa_sale_code = @p_code_barcode
          AND fsd_child.id IS NULL
        FOR XML PATH(''), TYPE
    ).value('.', 'nvarchar(max)'), 1, 2, ''); 

    IF ISNULL(@missing_asset, '') <> ''
    BEGIN
        IF RIGHT(@missing_asset, 1) = ','
        BEGIN
            SET @missing_asset = SUBSTRING(@missing_asset, 1, LEN(@missing_asset) - 1) + ' -';
        END

        SET @ErrorMessage = '\n- This transaction cannot be processed because the asset is still linked to another asset within the same group.' + '\n' +
            'Please remove it from the group first, or add all assets within the group.' + '\n\n' +
            'Missing asset:\n' + 
            @missing_asset;

        RAISERROR (
            @ErrorMessage,
            16,
            1
        );
        RETURN;
    END
END
GO


