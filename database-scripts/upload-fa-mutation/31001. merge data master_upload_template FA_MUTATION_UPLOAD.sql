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
