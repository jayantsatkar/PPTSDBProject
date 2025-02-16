CREATE TABLE [dbo].[TRN_BoxBarcodeDetails] (
    [TRN_BoxBarcodeDetails_ID] BIGINT       IDENTITY (1, 1) NOT NULL,
    [TRN_BoxSerialNo_ID]       BIGINT       NOT NULL,
    [BoxBatchCode]             VARCHAR (50) NOT NULL,
    [BoxSerialNo]              VARCHAR (10) NOT NULL,
    [MST_PartConfiguration_ID] BIGINT       NOT NULL,
    [Boschpart_No]             VARCHAR (21) NOT NULL,
    [ActualPart_Qty]           BIGINT       NULL,
    [PartBatchCode]            VARCHAR (20) NOT NULL,
    [PartSerialNo]             VARCHAR (10) NOT NULL,
    [Machine_ID]               BIGINT       NOT NULL,
    [Created_By]               BIGINT       NULL,
    [Created_On]               DATETIME     NULL,
    [Modified_By]              BIGINT       NULL,
    [Modified_On]              DATETIME     NULL,
    CONSTRAINT [PK_TRN_BoxBarcodeDetails] PRIMARY KEY CLUSTERED ([TRN_BoxBarcodeDetails_ID] ASC)
);

