CREATE TABLE [dbo].[inv_mutation_upload_staging](
	[upload_id] [uniqueidentifier] NULL,
	[file_name] [nvarchar](255) NULL,
	[row_number] [int] NULL,
	[from_branch] [nvarchar](50) NULL,
	[from_location] [nvarchar](50) NULL,
	[to_branch] [nvarchar](50) NULL,
	[to_location] [nvarchar](50) NULL,
	[description] [nvarchar](200) NULL,
	[item_code] [nvarchar](50) NULL,
	[quantity] [int] NULL,
	[upload_date] [datetime] NULL,
	[error_message] [nvarchar](500) NULL,
	[process_flag] [char](1) NULL,
	[process_date] [datetime] NULL,
	[im_code] [nvarchar](36) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[inv_mutation_upload_staging] ADD  DEFAULT (getdate()) FOR [upload_date]
GO


