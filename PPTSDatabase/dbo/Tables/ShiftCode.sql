CREATE TABLE [dbo].[ShiftCode] (
    [Id]          INT         NOT NULL,
    [ShiftACodes] VARCHAR (1) NOT NULL,
    [ShiftBCodes] VARCHAR (1) NOT NULL,
    [ShiftCCodes] VARCHAR (1) NOT NULL,
    CONSTRAINT [PK_ShiftCode] PRIMARY KEY CLUSTERED ([Id] ASC)
);

