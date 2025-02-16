CREATE TABLE [dbo].[MST_SubModule] (
    [Sub_Module_ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [Sub_Module_Name]        NVARCHAR (50) NOT NULL,
    [Sub_Module_Description] NVARCHAR (50) NULL,
    [Sub_Module_Order]       INT           NOT NULL,
    [IsActive]               BIT           NULL,
    [Module_ID]              BIGINT        NULL,
    [Created_On]             DATETIME      NOT NULL,
    [Created_By]             BIGINT        NOT NULL,
    [Modified_On]            DATETIME      NULL,
    [Modified_By]            BIGINT        NULL,
    CONSTRAINT [PK_MST_SubModule] PRIMARY KEY CLUSTERED ([Sub_Module_ID] ASC),
    CONSTRAINT [FK_MST_SubModule_MST_Module] FOREIGN KEY ([Module_ID]) REFERENCES [dbo].[MST_Module] ([Module_ID]),
    CONSTRAINT [FK_MST_SubModule_MST_User] FOREIGN KEY ([Created_By]) REFERENCES [dbo].[MST_User] ([User_ID]),
    CONSTRAINT [FK_MST_SubModule_MST_User1] FOREIGN KEY ([Modified_By]) REFERENCES [dbo].[MST_User] ([User_ID])
);

