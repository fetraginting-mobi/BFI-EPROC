IF COL_LENGTH('dbo.inv_mutation_upload_staging', 'upload_by') IS NULL
BEGIN
	ALTER TABLE [dbo].[inv_mutation_upload_staging]
	ADD [upload_by] [nvarchar](50) NULL;
END
GO
