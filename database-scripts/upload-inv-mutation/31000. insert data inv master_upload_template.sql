 insert into [dbo].[master_upload_template]
	SELECT 9 AS [id], N'INV_MUTATION_UPLOAD' AS [code], N'No' AS [coloumn_name], N'No' AS [description], 1 AS [sequence], CAST(0 AS BIT) AS [mandatory]
    UNION ALL SELECT 10, N'INV_MUTATION_UPLOAD', N'From_branch', N'From Branch', 2, CAST(1 AS BIT)
    UNION ALL SELECT 11, N'INV_MUTATION_UPLOAD', N'From_location', N'From Location', 3, CAST(1 AS BIT)
    UNION ALL SELECT 12, N'INV_MUTATION_UPLOAD', N'To_branch', N'To Branch', 4, CAST(1 AS BIT)
    UNION ALL SELECT 13, N'INV_MUTATION_UPLOAD', N'To_location', N'To Location', 5, CAST(1 AS BIT)
	UNION ALL SELECT 14, N'INV_MUTATION_UPLOAD', N'description', N'Deskripsi', 6, CAST(1 AS BIT)
    UNION ALL SELECT 15, N'INV_MUTATION_UPLOAD', N'item_code', N'Item Code', 7, CAST(1 AS BIT)
    UNION ALL SELECT 16, N'INV_MUTATION_UPLOAD', N'quantity', N'Quantity', 8, CAST(1 AS BIT)
