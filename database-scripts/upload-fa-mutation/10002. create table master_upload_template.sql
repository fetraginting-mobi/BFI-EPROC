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
