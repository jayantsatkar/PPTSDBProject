
-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: [spValidateUser]
-- Author			: NAMDEO
-- Updated on		: 30/09/2012
-- Database(s)		: AtlasCopco
-- Description 		: For validating user
-- ====================================================================================
CREATE PROCEDURE [dbo].[spValidateUser]
 @pLogin_Id nvarchar(50),
 @pUser_PWD nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
			
			Select  [User_ID]
			From MST_User 
			WHERE Login_ID=@pLogin_Id
			 		and  dbo.decryptdata([Password],8) collate sql_latin1_General_CP1_cs_as = @pUser_PWD
					and IsActive =1 group by [User_ID]
				

	
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

