CREATE TABLE [dbo].[MST_Role] (
    [Role_ID]     BIGINT        IDENTITY (1, 1) NOT NULL,
    [Role_Name]   NVARCHAR (25) NULL,
    [Role_Desc]   NVARCHAR (50) NULL,
    [IsActive]    BIT           NOT NULL,
    [Created_By]  BIGINT        NOT NULL,
    [Created_On]  DATETIME      NOT NULL,
    [Modified_By] BIGINT        NULL,
    [Modified_On] DATETIME      NULL,
    CONSTRAINT [PK_MST_Role] PRIMARY KEY CLUSTERED ([Role_ID] ASC)
);

