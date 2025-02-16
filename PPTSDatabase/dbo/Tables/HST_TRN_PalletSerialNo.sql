CREATE TABLE [dbo].[HST_TRN_PalletSerialNo] (
    [TRN_PalletSerialNo_ID] BIGINT        IDENTITY (1, 1) NOT NULL,
    [PalletSrNo]            NVARCHAR (10) NOT NULL,
    [InvoiceDate]           VARCHAR (30)  NULL,
    [PalletBatchCode]       VARCHAR (50)  NOT NULL,
    [PalletBarcode]         NVARCHAR (10) NOT NULL,
    [Machine_ID]            BIGINT        NOT NULL,
    [Created_By]            BIGINT        NULL,
    [Created_On]            DATETIME      NULL,
    [Modified_By]           BIGINT        NULL,
    [Modified_On]           DATETIME      NULL,
    [HST_Created_On]        DATETIME      NULL,
    CONSTRAINT [PK_HST_TRN_PalletSerialNo] PRIMARY KEY CLUSTERED ([TRN_PalletSerialNo_ID] ASC)
);

