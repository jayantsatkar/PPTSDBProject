CREATE TABLE [dbo].[TRN_PalletLable_Verify] (
    [Invoice_No]    VARCHAR (25)  NULL,
    [PartConfig_Id] NCHAR (10)    NULL,
    [InvoiceQty]    BIGINT        NOT NULL,
    [InvoiceDate]   VARCHAR (30)  NULL,
    [Machine_ID]    BIGINT        NULL,
    [Created_By]    BIGINT        NULL,
    [BoxBatchCode]  VARCHAR (25)  NULL,
    [BoxSerialNo]   NVARCHAR (10) NULL,
    [Code]          NVARCHAR (50) NULL
);

