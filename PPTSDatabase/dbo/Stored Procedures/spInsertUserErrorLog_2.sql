-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertUserErrorLog_2]

@LoginUserId	nvarchar(50),
@PartConfigNo	bigint,
@Approved_By	nvarchar(50),
@ErrorDescription	nvarchar(100),	
@InvoiceNo varchar(25),
@InvoiceDate varchar(30),
@InvoiceQty bigint


		
AS
BEGIN
	BEGIN TRY
		Begin transaction
		declare @id as bigint
		 select @id = ISNULL( max(Id) + 1, 1) from [dbo].[UserErrorLog_2] 
INSERT INTO [dbo].[UserErrorLog_2]
           ([Id]
		   ,[LoginUserId]
           ,[PartConfigNo]
           ,[Approved_By]
           ,[ErrorDescription]
           ,[Created_On]
           ,[Machine_Id]
		   ,[InvoiceNo]
           ,[InvoiceDate]
           ,[InvoiceQty])
     VALUES
           (@id
		   ,@LoginUserId
           ,@PartConfigNo
           ,@Approved_By
           ,@ErrorDescription
           ,getdate()
           ,1
		   ,@InvoiceNo
		   ,@InvoiceDate
		   ,@InvoiceQty)



		   select @id;
		   commit

    END TRY
	BEGIN CATCH
	SET NOCOUNT ON;
		rollback;
		select 0 
		INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME)
		SELECT ERROR_PROCEDURE(),
			  ERROR_LINE(),
			  ERROR_NUMBER(),
			  ERROR_MESSAGE(),
			  CURRENT_TIMESTAMP;

			  select 0;
	END CATCH
END

