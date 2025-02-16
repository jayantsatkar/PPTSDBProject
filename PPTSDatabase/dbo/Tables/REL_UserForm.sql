CREATE TABLE [dbo].[REL_UserForm] (
    [Sr_No]        BIGINT   IDENTITY (1, 1) NOT NULL,
    [User_Id]      BIGINT   NOT NULL,
    [Frm_Id]       BIGINT   NOT NULL,
    [Flag_Visible] BIT      NOT NULL,
    [Created_By]   BIGINT   NOT NULL,
    [Created_On]   DATETIME NOT NULL,
    [Modified_By]  BIGINT   NULL,
    [Modified_On]  DATETIME NULL,
    CONSTRAINT [PK_REL_UserForm] PRIMARY KEY CLUSTERED ([Sr_No] ASC)
);

