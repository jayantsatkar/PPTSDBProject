CREATE TABLE [dbo].[FileImportLogs] (
    [Id]        INT          IDENTITY (1, 1) NOT NULL,
    [Type]      NVARCHAR (50) NULL,
    [FileName]  NVARCHAR (50) NULL,
    [FilePath]  NVARCHAR (50) NULL,
    [CreatedBy] INT          NULL,
    [CreatedOn] DateTime      NULL
);

