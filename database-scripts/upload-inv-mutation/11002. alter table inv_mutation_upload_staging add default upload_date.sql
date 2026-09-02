IF NOT EXISTS (
	SELECT 1
	FROM sys.default_constraints dc
	INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id
	WHERE dc.parent_object_id = OBJECT_ID('dbo.inv_mutation_upload_staging')
		AND c.name = 'upload_date'
)
BEGIN
	ALTER TABLE [dbo].[inv_mutation_upload_staging]
	ADD CONSTRAINT DF_inv_mutation_upload_staging_upload_date DEFAULT (getdate()) FOR [upload_date];
END
GO
