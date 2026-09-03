IF COL_LENGTH('dbo.inv_mutation_upload_staging', 'im_code') IS NULL
BEGIN
	ALTER TABLE [dbo].[inv_mutation_upload_staging]
	ADD [im_code] [nvarchar](36) NULL;
END
GO
