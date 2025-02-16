create PROC [dbo].[usp_FindUser]	 -- ''
@Text VARCHAR(50)
AS
BEGIN
SELECT User_ID as UserId, Login_ID	 ,	   	   First_Name	 ,Last_Name	 ,EmployeeId FROM MST_User WHERE Login_ID LIKE '%'+@Text+'%'  OR  First_Name  LIKE '%'+@Text+'%' OR Last_Name	LIKE '%'+@Text+'%'
END
							   
