SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[xsp_fa_post_mutation_upload_history_getrows]', 'P') IS NULL
    EXEC('CREATE PROCEDURE [dbo].[xsp_fa_post_mutation_upload_history_getrows] AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROCEDURE [dbo].[xsp_fa_post_mutation_upload_history_getrows]
(
    @p_im_code NVARCHAR(56)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        apl.CODE_BARCODE AS code_barcode,
        apl.PROCESS_NAME AS process_name,
        apl.BARCODE AS item_code,
        ISNULL(fa.AST_NAME, apl.RAW_DATA) AS item_name,
        apl.QUANTITY AS quantity,
        apl.ERROR_MESSAGE AS error_message,
        apl.CRE_DATE AS [date]
    FROM dbo.APP_PROCESS_ERROR_LOG apl WITH (NOLOCK)
    LEFT JOIN dbo.FA_ASSET fa WITH (NOLOCK)
        ON apl.BARCODE = fa.BARCODE
    WHERE apl.CODE_BARCODE = @p_im_code
    ORDER BY apl.CRE_DATE DESC, apl.BARCODE DESC;
END
GO
