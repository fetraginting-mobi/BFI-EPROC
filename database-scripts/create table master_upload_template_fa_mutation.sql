USE [LIVE_BFI_DEV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[master_upload_template]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[master_upload_template]
    (
        [id] INT NOT NULL,
        [code] NVARCHAR(50) NOT NULL,
        [coloumn_name] NVARCHAR(100) NOT NULL,
        [description] NVARCHAR(200) NOT NULL,
        [sequence] INT NOT NULL,
        [mandatory] BIT NOT NULL,
        CONSTRAINT [PK_master_upload_template] PRIMARY KEY CLUSTERED ([id] ASC)
    );
END
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE object_id = OBJECT_ID('[dbo].[master_upload_template]')
        AND name = 'IX_master_upload_template_code_sequence'
)
BEGIN
    CREATE INDEX [IX_master_upload_template_code_sequence]
        ON [dbo].[master_upload_template] ([code], [sequence]);
END
GO

MERGE [dbo].[master_upload_template] AS target
USING (
    SELECT 1 AS [id], N'FA_MUTATION_UPLOAD' AS [code], N'No' AS [coloumn_name], N'No' AS [description], 1 AS [sequence], CAST(0 AS BIT) AS [mandatory]
    UNION ALL SELECT 2, N'FA_MUTATION_UPLOAD', N'From_branch', N'From Branch', 2, CAST(1 AS BIT)
    UNION ALL SELECT 3, N'FA_MUTATION_UPLOAD', N'From_location', N'From Location', 3, CAST(1 AS BIT)
    UNION ALL SELECT 4, N'FA_MUTATION_UPLOAD', N'To_branch', N'To Branch', 4, CAST(1 AS BIT)
    UNION ALL SELECT 5, N'FA_MUTATION_UPLOAD', N'To_location', N'To Location', 5, CAST(1 AS BIT)
    UNION ALL SELECT 6, N'FA_MUTATION_UPLOAD', N'owner', N'Owner', 6, CAST(1 AS BIT)
    UNION ALL SELECT 7, N'FA_MUTATION_UPLOAD', N'asset_Code', N'Asset Code', 7, CAST(1 AS BIT)
    UNION ALL SELECT 8, N'FA_MUTATION_UPLOAD', N'description', N'Deskripsi', 8, CAST(0 AS BIT)
) AS source
ON target.[id] = source.[id]
WHEN MATCHED THEN
    UPDATE SET
        [code] = source.[code],
        [coloumn_name] = source.[coloumn_name],
        [description] = source.[description],
        [sequence] = source.[sequence],
        [mandatory] = source.[mandatory]
WHEN NOT MATCHED THEN
    INSERT ([id], [code], [coloumn_name], [description], [sequence], [mandatory])
    VALUES (source.[id], source.[code], source.[coloumn_name], source.[description], source.[sequence], source.[mandatory]);
GO

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
GO
