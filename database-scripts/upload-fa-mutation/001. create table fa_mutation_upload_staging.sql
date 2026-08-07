CREATE TABLE [dbo].[fa_mutation_upload_staging](
	[upload_id] [uniqueidentifier] NULL,
	[file_name] [nvarchar](255) NULL,
	[row_number] [int] NULL,
	[from_cost_center] [nvarchar](50) NULL,
	[from_location] [nvarchar](50) NULL,
	[to_cost_center] [nvarchar](50) NULL,
	[to_location] [nvarchar](50) NULL,
	[owner] [nvarchar](50) NULL,
	[asset_code] [nvarchar](50) NULL,
	[description] [nvarchar](200) NULL,
	[upload_by] [nvarchar](50) NULL,
	[upload_date] [datetime] NULL,
	[error_message] [nvarchar](500) NULL,
	[process_flag] [char](1) NULL,
	[process_date] [datetime] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[fa_mutation_upload_staging] ADD  DEFAULT (getdate()) FOR [upload_date]
GO


