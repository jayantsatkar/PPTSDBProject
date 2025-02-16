CREATE TABLE [dbo].[MST_BioMetric] (
    [MST_BioMetric_ID] BIGINT          IDENTITY (1, 1) NOT NULL,
    [User_ID]          BIGINT          NOT NULL,
    [FingerPrint1]     VARBINARY (MAX) NOT NULL,
    [IsActive]         BIT             NULL,
    [Created_On]       DATETIME        NULL,
    [Created_By]       BIGINT          NULL,
    [Modified_By]      BIGINT          NULL,
    [Modified_On]      DATETIME        NULL,
    CONSTRAINT [PK_MST_BioMetric] PRIMARY KEY CLUSTERED ([MST_BioMetric_ID] ASC)
);

