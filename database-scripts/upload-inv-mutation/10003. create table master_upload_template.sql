CREATE TABLE [dbo].[master_upload_template](
	[id] [int] NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[coloumn_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](200) NOT NULL,
	[sequence] [int] NOT NULL,
	[mandatory] [bit] NOT NULL,
 CONSTRAINT [PK_master_upload_template] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


