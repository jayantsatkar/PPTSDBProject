CREATE TABLE [dbo].[HST_TRN_BoxSerialNo] (
    [TRN_BoxSerialNo_ID]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [MST_PartConfiguration_ID] BIGINT        NOT NULL,
    [BoxSerial_No]             NVARCHAR (10) NOT NULL,
    [BoxBatchCode]             VARCHAR (50)  NOT NULL,
    [BoxBarcode]               NVARCHAR (50) NOT NULL,
    [ActualPart_Qty]           BIGINT        NOT NULL,
    [Machine_ID]               BIGINT        NOT NULL,
    [Created_By]               BIGINT        NULL,
    [Created_On]               DATETIME      NULL,
    [Modified_By]              BIGINT        NULL,
    [Modified_On]              DATETIME      NULL,
    [HST_Created_On]           DATETIME      NULL,
    CONSTRAINT [PK_HST_TRN_BoxSerialNo] PRIMARY KEY CLUSTERED ([TRN_BoxSerialNo_ID] ASC)
);

