ALTER TABLE [dbo].[fa_mutation_upload_staging] ADD DEFAULT (getdate()) FOR [upload_date]
GO
