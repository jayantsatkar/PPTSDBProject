CREATE PROC [dbo].[usp_GetRolesByUser]  --23
@UserID int
AS  
BEGIN  
SELECT MST_Role.Role_Id AS roleId , --RoleCode AS  roleCode, 
Role_Name AS roleName, 
Role_Desc AS roleDesc, 
CONVERT(VARCHAR,MST_Role.Created_On,106) AS createdOn ,  
CONVERT(VARCHAR,MST_Role.Modified_On,106)  AS modifiedOn   
FROM MST_Role as MST_Role   
Join MST_User _t1 on _t1.Role_Id=MST_Role.Role_Id 
WHERE MST_Role.IsActive=1  and _t1.User_Id=@UserID
END
