-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertUserErrorLog]

@LoginUserId	nvarchar(50),
@PartConfigNo	bigint,
@Approved_By	nvarchar(50),
@ErrorDescription	nvarchar(100)	

		
AS
BEGIN
	BEGIN TRY
		Begin transaction
		declare @id as bigint
		 select @id = ISNULL( max(Id) + 1, 1) from [dbo].[UserErrorLog] 
INSERT INTO [dbo].[UserErrorLog]
           ([Id]
		   ,[LoginUserId]
           ,[PartConfigNo]
           ,[Approved_By]
           ,[ErrorDescription]
           ,[Created_On]
           ,[Machine_Id])
     VALUES
           (@id
		   ,@LoginUserId
           ,@PartConfigNo
           ,@Approved_By
           ,@ErrorDescription
           ,getdate()
           ,1)

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

