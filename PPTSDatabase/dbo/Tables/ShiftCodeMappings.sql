CREATE TABLE [dbo].[ShiftCodeMappings] (
    [Id]         INT         NOT NULL,
    [ShiftCodes] VARCHAR (2) NOT NULL,
    CONSTRAINT [PK_ShiftCodeMappings] PRIMARY KEY CLUSTERED ([Id] ASC)
);

