CREATE TABLE [dbo].[MST_Machine] (
    [MST_Machine_ID] BIGINT       IDENTITY (1, 1) NOT NULL,
    [Machine_No]     VARCHAR (5)  NOT NULL,
    [Machine_Name]   VARCHAR (30) NOT NULL,
    [IPAddress]      VARCHAR (25) NULL,
    [Created_By]     BIGINT       NULL,
    [Created_On]     DATETIME     NULL,
    [Modified_By]    BIGINT       NULL,
    [Modified_On]    DATETIME     NULL,
    CONSTRAINT [PK_MST_Machine] PRIMARY KEY CLUSTERED ([MST_Machine_ID] ASC),
    CONSTRAINT [FK_MST_Machine_MST_User] FOREIGN KEY ([Created_By]) REFERENCES [dbo].[MST_User] ([User_ID]),
    CONSTRAINT [FK_MST_Machine_MST_User1] FOREIGN KEY ([Modified_By]) REFERENCES [dbo].[MST_User] ([User_ID])
);

