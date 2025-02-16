CREATE TABLE [dbo].[MST_Customer] (
    [MST_Customer_ID] BIGINT        IDENTITY (1, 1) NOT NULL,
    [Customer_Code]   VARCHAR (10)  NOT NULL,
    [Customer_Name]   VARCHAR (50)  NOT NULL,
    [Customer_Index]  VARCHAR (5)   NOT NULL,
    [Address_Line1]   VARCHAR (100) NULL,
    [Address_Line2]   VARCHAR (100) NULL,
    [PhoneNo]         VARCHAR (20)  NULL,
    [FaxNo]           VARCHAR (20)  NULL,
    [EmailId]         VARCHAR (50)  NULL,
    [Created_By]      BIGINT        NULL,
    [Created_On]      DATETIME      NULL,
    [Modified_By]     BIGINT        NULL,
    [Modified_On]     DATETIME      NULL,
    CONSTRAINT [PK_MST_Customer] PRIMARY KEY CLUSTERED ([MST_Customer_ID] ASC),
    CONSTRAINT [FK_MST_Customer_MST_User] FOREIGN KEY ([Created_By]) REFERENCES [dbo].[MST_User] ([User_ID]),
    CONSTRAINT [FK_MST_Customer_MST_User1] FOREIGN KEY ([Modified_By]) REFERENCES [dbo].[MST_User] ([User_ID])
);

