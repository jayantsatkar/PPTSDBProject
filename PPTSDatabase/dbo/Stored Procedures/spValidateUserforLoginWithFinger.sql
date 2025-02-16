CREATE PROCEDURE [dbo].[spValidateUserforLoginWithFinger]
 @pLogin_Id nvarchar(50)
-- @pUser_PWD nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
			
			Select  
			[User_ID],
			IsFingerPrint, Role_ID
			From MST_User 
			WHERE Login_ID=@pLogin_Id
			 		--and  [Password]=@pUser_PWD
					and IsActive =1 ;
				

	
	END TRY
	BEGIN CATCH
	SET NOCOUNT ON;
		rollback;
		select 0 as result;
		INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME)
		SELECT ERROR_PROCEDURE(),
			  ERROR_LINE(),
			  ERROR_NUMBER(),
			  ERROR_MESSAGE(),
			  CURRENT_TIMESTAMP;
	END CATCH
END
