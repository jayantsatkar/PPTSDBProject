CREATE TABLE [dbo].[MonthCode] (
    [Id]        INT         NOT NULL,
    [MonthName] VARCHAR (3) NOT NULL,
    [MonthCode] VARCHAR (1) NOT NULL,
    [MonthId]   VARCHAR (2) NOT NULL,
    CONSTRAINT [PK_MonthCode] PRIMARY KEY CLUSTERED ([Id] ASC)
);

