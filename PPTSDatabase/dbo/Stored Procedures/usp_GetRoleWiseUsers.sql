
CREATE PROC [dbo].[usp_GetRoleWiseUsers]  
@RoleId INT
AS  
BEGIN  
  
 
 select U.User_Id AS userId,U.Role_Id AS roleId, U.EmployeeId AS employeeId ,U.Login_Id as LoginID ,U.First_Name + ' ' + U.Last_Name AS userName
 from 
  MST_User U
  WHERE U.IsActive=1  AND  U.Role_Id=@RoleId

END