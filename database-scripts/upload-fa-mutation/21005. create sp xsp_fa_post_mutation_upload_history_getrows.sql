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
        apl.code_barcode,
        apl.process_name,
        apl.barcode AS item_code,
        ISNULL(fa.ast_name, apl.raw_data) AS item_name,
        apl.quantity,
        apl.error_message,
        apl.cre_date AS [date]
    FROM app_process_error_log apl WITH (NOLOCK)
        LEFT JOIN fa_asset fa WITH (NOLOCK) ON apl.barcode = fa.barcode
    WHERE apl.code_barcode = @p_im_code
    ORDER BY apl.cre_date DESC, apl.barcode DESC;
END
GO
