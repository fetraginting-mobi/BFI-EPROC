IF OBJECT_ID('[dbo].[xsp_master_upload_template_getrows]', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[xsp_master_upload_template_getrows]
GO

CREATE PROCEDURE [dbo].[xsp_master_upload_template_getrows]
(
    @p_code NVARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [id],
        [code],
        [coloumn_name],
        [description],
        [sequence],
        [mandatory]
    FROM [dbo].[master_upload_template]
    WHERE [code] = @p_code
    ORDER BY [sequence], [id];
END
GO