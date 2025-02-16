CREATE TABLE [dbo].[HST_TRN_ScanPartBarcode] (
    [TRN_ScanPartBarcode_ID] BIGINT        IDENTITY (1, 1) NOT NULL,
    [PartBarcode]            NVARCHAR (60) NOT NULL,
    [PartSerialNo]           NVARCHAR (10) NOT NULL,
    [Machine_ID]             BIGINT        NOT NULL,
    [Created_By]             BIGINT        NULL,
    [Created_On]             DATETIME      NULL,
    [Modified_By]            BIGINT        NULL,
    [Modified_On]            DATETIME      NULL,
    [HST_Created_On]         DATETIME      NULL,
    CONSTRAINT [PK_HST_TRN_ScanPartBarcode] PRIMARY KEY CLUSTERED ([TRN_ScanPartBarcode_ID] ASC)
);

