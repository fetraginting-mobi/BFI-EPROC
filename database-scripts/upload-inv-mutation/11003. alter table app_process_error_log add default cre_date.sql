IF NOT EXISTS (
	SELECT 1
	FROM sys.default_constraints dc
	INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id
	WHERE dc.parent_object_id = OBJECT_ID('dbo.APP_PROCESS_ERROR_LOG')
		AND c.name = 'CRE_DATE'
)
BEGIN
	ALTER TABLE [dbo].[APP_PROCESS_ERROR_LOG]
	ADD CONSTRAINT DF_APP_PROCESS_ERROR_LOG_CRE_DATE DEFAULT (getdate()) FOR [CRE_DATE];
END
GO
