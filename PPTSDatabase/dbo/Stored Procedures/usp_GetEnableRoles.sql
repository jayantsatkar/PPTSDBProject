  
  
CREATE PROC  [dbo].[usp_GetEnableRoles]  
AS  
BEGIN  
SELECT MST_Role.Role_ID AS roleId , --RoleCode AS  roleCode, 
Role_Name AS roleName,        
Role_Desc AS roleDesc, MST_User.First_Name AS createdBy, CONVERT(VARCHAR,MST_Role.Created_On,106) AS createdOn ,        
_t2.First_Name AS modifiedBy, CONVERT(VARCHAR,MST_Role.Modified_On,106)  AS modifiedOn  
-- ,   MST_Role.IsEnabled as IsRoleActive    
FROM MST_Role as MST_Role       
        
LEFT JOIN MST_User  ON MST_User.User_ID = MST_Role.Created_By        
left JOIN MST_User _t2 ON _t2.User_ID = MST_Role.Modified_By        
 WHERE MST_Role.IsActive=1 --AND MST_Role.IsEnabled=1  
 ORDER BY CASE When MST_Role.Modified_On is null then MST_Role.Created_On ELSE MST_Role.Modified_On END  DESC      
END   