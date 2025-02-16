CREATE TABLE [dbo].[YearCode] (
    [Id]         INT         NOT NULL,
    [YearName]   VARCHAR (4) NOT NULL,
    [YearCode]   VARCHAR (1) NOT NULL,
    [YearString] VARCHAR (2) NOT NULL,
    CONSTRAINT [PK_YearCode] PRIMARY KEY CLUSTERED ([Id] ASC)
);

