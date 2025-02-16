CREATE TABLE [dbo].[MST_Module] (
    [Module_ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [Module_Name]        NVARCHAR (50) NOT NULL,
    [Module_Description] NVARCHAR (50) NULL,
    [Module_Order]       INT           NULL,
    [IsActive]           BIT           NULL,
    [Created_On]         DATETIME      NOT NULL,
    [Created_By]         BIGINT        NOT NULL,
    [Modified_On]        DATETIME      NULL,
    [Modified_By]        BIGINT        NULL,
    CONSTRAINT [PK_MST_Module] PRIMARY KEY CLUSTERED ([Module_ID] ASC),
    CONSTRAINT [FK_MST_Module_MST_User] FOREIGN KEY ([Modified_By]) REFERENCES [dbo].[MST_User] ([User_ID]),
    CONSTRAINT [FK_MST_Module_MST_User1] FOREIGN KEY ([Created_By]) REFERENCES [dbo].[MST_User] ([User_ID])
);

