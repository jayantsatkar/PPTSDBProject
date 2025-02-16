CREATE TABLE [dbo].[TRN_ScanPartBarcode] (
    [TRN_ScanPartBarcode_ID] BIGINT        IDENTITY (1, 1) NOT NULL,
    [PartBarcode]            NVARCHAR (60) NOT NULL,
    [PartSerialNo]           NVARCHAR (10) NOT NULL,
    [Machine_ID]             BIGINT        NOT NULL,
    [Created_By]             BIGINT        NULL,
    [Created_On]             DATETIME      NULL,
    [Modified_By]            BIGINT        NULL,
    [Modified_On]            DATETIME      NULL,
    CONSTRAINT [PK_TRN_ScanPartBarcode] PRIMARY KEY CLUSTERED ([TRN_ScanPartBarcode_ID] ASC),
    CONSTRAINT [FK_TRN_ScanPartBarcode_MST_Machine] FOREIGN KEY ([Machine_ID]) REFERENCES [dbo].[MST_Machine] ([MST_Machine_ID]),
    CONSTRAINT [FK_TRN_ScanPartBarcode_MST_User] FOREIGN KEY ([Created_By]) REFERENCES [dbo].[MST_User] ([User_ID]),
    CONSTRAINT [FK_TRN_ScanPartBarcode_MST_User1] FOREIGN KEY ([Modified_By]) REFERENCES [dbo].[MST_User] ([User_ID])
);

