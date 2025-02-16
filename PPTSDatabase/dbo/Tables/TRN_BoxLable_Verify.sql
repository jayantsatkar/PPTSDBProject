CREATE TABLE [dbo].[TRN_BoxLable_Verify] (
    [PartConfig_Id] BIGINT         NULL,
    [PartActualQty] BIGINT         NULL,
    [MachineId]     BIGINT         NULL,
    [created_By]    BIGINT         NULL,
    [BoschPartNo]   NVARCHAR (21)  NULL,
    [PartBatchCode] NVARCHAR (20)  NULL,
    [PartSerialNo]  VARCHAR (50)   NULL,
    [Code]          NVARCHAR (100) NULL,
    [CreatedOn]     DATETIME       CONSTRAINT [DF_TRN_BoxLable_Verify_CreatedOn] DEFAULT (getdate()) NULL
);

