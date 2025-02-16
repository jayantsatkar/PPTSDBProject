CREATE TABLE [dbo].[HST_TRN_InvoiceDetails] (
    [TRN_InvoiceDetails_ID]    BIGINT        IDENTITY (1, 1) NOT NULL,
    [InvoiceNo]                NVARCHAR (20) NOT NULL,
    [TRN_PalletSerialNo_ID]    BIGINT        NOT NULL,
    [PalletSerial_No]          NVARCHAR (10) NOT NULL,
    [TRN_BoxSerialNo_ID]       BIGINT        NOT NULL,
    [BoxSerialNo]              NVARCHAR (10) NOT NULL,
    [TRN_BoxBarcodeDetails_ID] BIGINT        NOT NULL,
    [BoxBatchCode]             VARCHAR (20)  NOT NULL,
    [Invoice_Qty]              BIGINT        NOT NULL,
    [Pallet_Qty]               BIGINT        NOT NULL,
    [Machine_ID]               BIGINT        NOT NULL,
    [Created_By]               BIGINT        NULL,
    [Created_On]               DATETIME      NULL,
    [Modified_By]              BIGINT        NULL,
    [Modified_On]              DATETIME      NULL,
    [HST_Created_On]           DATETIME      NULL,
    CONSTRAINT [PK_HST_TRN_InvoiceDetails] PRIMARY KEY CLUSTERED ([TRN_InvoiceDetails_ID] ASC)
);

