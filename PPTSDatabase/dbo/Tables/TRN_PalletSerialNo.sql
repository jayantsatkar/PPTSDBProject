CREATE TABLE [dbo].[TRN_PalletSerialNo] (
    [TRN_PalletSerialNo_ID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [Invoice_No]            VARCHAR (25)   NOT NULL,
    [InvoiceDate]           VARCHAR (30)   NULL,
    [PalletSrNo]            NVARCHAR (10)  NOT NULL,
    [PalletBatchCode]       NVARCHAR (50)  NULL,
    [PalletBarcode]         NVARCHAR (100) NOT NULL,
    [InvoiceQty]            BIGINT         NOT NULL,
    [Machine_ID]            BIGINT         NOT NULL,
    [Created_By]            BIGINT         NULL,
    [Created_On]            DATETIME       NULL,
    [Modified_By]           BIGINT         NULL,
    [Modified_On]           DATETIME       NULL,
    CONSTRAINT [PK_TRN_PalletSerialNo] PRIMARY KEY CLUSTERED ([TRN_PalletSerialNo_ID] ASC)
);

