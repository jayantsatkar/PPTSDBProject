CREATE TABLE [dbo].[TRN_InvoiceDetails] (
    [TRN_InvoiceDetails_ID] BIGINT        IDENTITY (1, 1) NOT NULL,
    [TRN_PalletSerialNo_ID] BIGINT        NOT NULL,
    [InvoiceNo]             NVARCHAR (25) NOT NULL,
    [PalletSerial_No]       NVARCHAR (10) NOT NULL,
    [BoxSerialNo]           NVARCHAR (10) NOT NULL,
    [TRN_BoxSerialNo_ID]    BIGINT        NOT NULL,
    [BoxBatchCode]          VARCHAR (25)  NOT NULL,
    [Pallet_Qty]            BIGINT        NOT NULL,
    [Machine_ID]            BIGINT        NOT NULL,
    [Created_By]            BIGINT        NULL,
    [Created_On]            DATETIME      NULL,
    [Modified_By]           BIGINT        NULL,
    [Modified_On]           DATETIME      NULL,
    CONSTRAINT [PK_TRN_InvoiceDetails] PRIMARY KEY CLUSTERED ([TRN_InvoiceDetails_ID] ASC),
    CONSTRAINT [FK_TRN_InvoiceDetails_MST_Machine] FOREIGN KEY ([Machine_ID]) REFERENCES [dbo].[MST_Machine] ([MST_Machine_ID]),
    CONSTRAINT [FK_TRN_InvoiceDetails_MST_User] FOREIGN KEY ([Created_By]) REFERENCES [dbo].[MST_User] ([User_ID]),
    CONSTRAINT [FK_TRN_InvoiceDetails_MST_User1] FOREIGN KEY ([Modified_By]) REFERENCES [dbo].[MST_User] ([User_ID]),
    CONSTRAINT [FK_TRN_InvoiceDetails_TRN_BoxSerialNo] FOREIGN KEY ([TRN_BoxSerialNo_ID]) REFERENCES [dbo].[TRN_BoxSerialNo] ([TRN_BoxSerialNo_ID])
);

