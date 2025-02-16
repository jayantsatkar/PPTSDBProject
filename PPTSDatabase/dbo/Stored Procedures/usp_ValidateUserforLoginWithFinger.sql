CREATE PROCEDURE [dbo].[usp_ValidateUserforLoginWithFinger]
 @LoginId varchar(50)
-- @pUser_PWD nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
			
			Select  
			MST_User.[User_ID],Login_Id		 ,First_Name,
			IsFingerPrint, Role_ID, FingerPrint1,[Password]
			From MST_User 
			INNER JOIN mst_BioMetric ON	 MST_User.[User_ID]= mst_BioMetric.[User_ID]
			WHERE Login_ID=@LoginId
			 		
					and MST_User.IsActive =1 ;
				

	
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
