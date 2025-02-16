CREATE TABLE [dbo].[MST_PartConfiguration] (
    [MST_PartConfiguration_ID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [BoschPart_No]             NVARCHAR (18)  NOT NULL,
    [Customer_Index]           VARCHAR (5)    NOT NULL,
    [MST_Customer_ID]          BIGINT         NOT NULL,
    [BoschPart_Desc]           NVARCHAR (200) NOT NULL,
    [CustPart_No]              NVARCHAR (30)  NULL,
    [NoOfPartQy_Box]           BIGINT         NOT NULL,
    [Packed_In]                VARCHAR (20)   NULL,
    [Line_Id]                  VARCHAR (5)    NULL,
    [Line_No]                  VARCHAR (10)   NULL,
    [Created_By]               BIGINT         NULL,
    [Created_On]               DATETIME       NULL,
    [Modified_By]              BIGINT         NULL,
    [Modified_On]              DATETIME       NULL,
    CONSTRAINT [PK_MST_PartNoConfiguration] PRIMARY KEY CLUSTERED ([MST_PartConfiguration_ID] ASC),
    CONSTRAINT [FK_MST_PartConfiguration_MST_Customer] FOREIGN KEY ([MST_Customer_ID]) REFERENCES [dbo].[MST_Customer] ([MST_Customer_ID]),
    CONSTRAINT [FK_MST_PartConfiguration_MST_User] FOREIGN KEY ([Created_By]) REFERENCES [dbo].[MST_User] ([User_ID]),
    CONSTRAINT [FK_MST_PartConfiguration_MST_User1] FOREIGN KEY ([Modified_By]) REFERENCES [dbo].[MST_User] ([User_ID])
);

