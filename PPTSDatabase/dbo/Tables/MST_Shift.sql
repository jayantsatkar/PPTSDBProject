CREATE TABLE [dbo].[MST_Shift](
	[ShiftId] [int] IDENTITY(1,1) NOT NULL,
	[ShiftName] [nvarchar](50) NOT NULL ,
	[ShiftCode] [nvarchar](50) NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[IsNightShift] [bit] NULL DEFAULT (0),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL DEFAULT (getdate()),
	
 CONSTRAINT [PK_MST_Shift] PRIMARY KEY CLUSTERED 
(
	[ShiftId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
