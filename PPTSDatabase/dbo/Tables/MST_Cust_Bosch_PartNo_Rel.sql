CREATE TABLE [dbo].[MST_Cust_Bosch_PartNo_Rel] (
    [Sr_No]           INT           IDENTITY (1, 1) NOT NULL,
    [Customer_Code]   BIGINT        NULL,
    [Customer_PartNo] VARCHAR (100) NULL,
    [Bosch_PartNo]    VARCHAR (100) NULL,
    [Kanban_ID]       VARCHAR (20)  NULL
);

