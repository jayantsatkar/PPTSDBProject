-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spGetFormsandModuleforUser 
-- Author			: Kirti
-- Created			: 10/10/2016
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spUserErrorLogReport]
	@User_ID nvarchar (50)
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		
select LoginUserId as [Login ID] , ISNULL( x.First_Name, '')+' '+ ISNULL( x.Middle_Name, '') 
+' '+ ISNULL( x.Last_Name, '') as [Login Name], ErrorDescription as [Error Description], PartConfigNo as [Part Config. No], z.CustPart_No, Approved_By,
 ISNULL ( y.First_Name, '') +' ' + ISNULL( y.Middle_Name, '') +' '+ ISNULL( y.Last_Name, '') as [Approved_By Name]  
, UserErrorLog.Created_On from
 UserErrorLog inner join MST_User as x
on UserErrorLog.LoginUserId = x.Login_ID
left join MST_User as y 
on UserErrorLog.Approved_By = y.Login_ID
inner join [dbo].[MST_PartConfiguration] as z on PartConfigNo = z.MST_PartConfiguration_ID
where UserErrorLog.LoginUserId = @User_ID
order by UserErrorLog.Created_On desc


	
	END TRY
	BEGIN CATCH
	SET NOCOUNT ON;
		INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME)
		SELECT ERROR_PROCEDURE(),
			  ERROR_LINE(),
			  ERROR_NUMBER(),
			  ERROR_MESSAGE(),
			  CURRENT_TIMESTAMP;
	END CATCH
END


