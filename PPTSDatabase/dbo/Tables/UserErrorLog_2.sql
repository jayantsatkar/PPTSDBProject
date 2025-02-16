CREATE TABLE [dbo].[UserErrorLog_2] (
    [Id]               BIGINT         NULL,
    [LoginUserId]      NVARCHAR (50)  NULL,
    [PartConfigNo]     BIGINT         NULL,
    [Approved_By]      NVARCHAR (50)  NULL,
    [ErrorDescription] NVARCHAR (100) NULL,
    [Created_On]       DATETIME       NULL,
    [Machine_Id]       BIGINT         NULL,
    [InvoiceNo]        VARCHAR (25)   NULL,
    [InvoiceDate]      VARCHAR (30)   NULL,
    [InvoiceQty]       BIGINT         NULL
);

