CREATE TABLE [dbo].[DayCode] (
    [Id]           INT         NOT NULL,
    [ShiftCode1-2] VARCHAR (1) NOT NULL,
    [ShiftCode3]   VARCHAR (1) NOT NULL,
    [DayCode]      VARCHAR (2) NOT NULL,
    CONSTRAINT [PK_DayCode] PRIMARY KEY CLUSTERED ([Id] ASC)
);

