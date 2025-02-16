CREATE TABLE [dbo].[MST_Form] (
    [Frm_Id]        BIGINT         IDENTITY (1, 1) NOT NULL,
    [Module_ID]     BIGINT         NULL,
    [Sub_Module_ID] BIGINT         NULL,
    [Frm_Name]      NVARCHAR (100) NOT NULL,
    [Frm_URL]       NVARCHAR (200) NOT NULL,
    [Frm_Order]     BIGINT         NOT NULL,
    [Created_By]    BIGINT         NOT NULL,
    [Created_On]    DATETIME       NULL,
    [Modified_By]   BIGINT         NULL,
    [Modified_On]   DATETIME       NULL,
    CONSTRAINT [PK_MST_Form] PRIMARY KEY CLUSTERED ([Frm_Id] ASC),
    CONSTRAINT [FK_MST_Form_MST_Module] FOREIGN KEY ([Module_ID]) REFERENCES [dbo].[MST_Module] ([Module_ID]),
    CONSTRAINT [FK_MST_Form_MST_User] FOREIGN KEY ([Created_By]) REFERENCES [dbo].[MST_User] ([User_ID]),
    CONSTRAINT [FK_MST_Form_MST_User1] FOREIGN KEY ([Modified_By]) REFERENCES [dbo].[MST_User] ([User_ID])
);

