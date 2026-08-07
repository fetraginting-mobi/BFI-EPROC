IF OBJECT_ID('[dbo].[xsp_famutation_list_item_getrows]', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[xsp_famutation_list_item_getrows]
GO

CREATE PROCEDURE [dbo].[xsp_famutation_list_item_getrows]
(
    @p_code NVARCHAR(50) = N'FA_MUTATION_UPLOAD'
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @cols NVARCHAR(MAX);
    DECLARE @sql NVARCHAR(MAX);

    SELECT @cols = STUFF((
        SELECT
            ', ' +
            CASE WHEN [sequence] = 1
                THEN 'No'
                ELSE 'CAST(NULL AS NVARCHAR(200))'
            END +
            ' AS ' + QUOTENAME([description] + CASE WHEN [mandatory] = 1 THEN '*' ELSE '' END)
        FROM [dbo].[master_upload_template]
        WHERE [code] = @p_code
        ORDER BY [sequence], [id]
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'), 1, 2, '');

    IF ISNULL(@cols, '') = ''
    BEGIN
        RAISERROR('Template upload tidak ditemukan.', 16, 1);
        RETURN;
    END;

    SET @sql = N'
        WITH cte AS (
            SELECT TOP (10)
                CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS INT) AS No
            FROM sys.objects
        )
        SELECT ' + @cols + N'
        FROM cte;';

    EXEC sp_executesql @sql;
END