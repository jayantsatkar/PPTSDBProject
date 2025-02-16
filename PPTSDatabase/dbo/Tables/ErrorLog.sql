﻿CREATE TABLE [dbo].[ErrorLog] (
    [ERROR_PROCEDURE] NVARCHAR (128)  NULL,
    [ERROR_LINE]      INT             NULL,
    [ERROR_NUMBER]    INT             NULL,
    [ERROR_MESSAGE]   NVARCHAR (4000) NULL,
    [ERROR_TIME]      DATETIME        NOT NULL,
    [ERROR_TYPE]      CHAR (1)        CONSTRAINT [DF_ErrorLog_ERROR_TYPE] DEFAULT ('E') NOT NULL
);

