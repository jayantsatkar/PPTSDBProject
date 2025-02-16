-- =============================================
-- Author     :	Pramod Desai	
-- Create date: 11/04/2011
-- Description:	Used For Getting all the user information
-- created By: Pramod Desai
-- =============================================
CREATE PROCEDURE [dbo].[spGetUserInfo] 
	@pLoginID nvarchar(50),
	@pPass nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		  select [User_ID],
				 Login_ID,
				 Role_ID,
				 First_Name
		   from MST_User
		   where Login_ID = @pLoginID
		   and [password] =@pPass
		   and IsActive =1
	END TRY
	begin catch
	SET NOCOUNT ON;
		INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME,ERROR_TYPE)
		SELECT ERROR_PROCEDURE(),
			  ERROR_LINE(),
			  ERROR_NUMBER(),
			  ERROR_MESSAGE(),
			  CURRENT_TIMESTAMP,'E';
	end catch	
END

