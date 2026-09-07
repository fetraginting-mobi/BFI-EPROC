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
