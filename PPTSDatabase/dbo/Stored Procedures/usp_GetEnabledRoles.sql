CREATE PROC [dbo].[usp_GetEnabledRoles]      
AS      
BEGIN      
      
PRINT 'SP IS NOT NEEDED'    
--SELECT MST_Role.RoleId AS roleId , RoleCode AS  roleCode, RoleName AS roleName,      
--RoleDesc AS roleDesc, MST_User.FirstName AS createdBy, CONVERT(VARCHAR,MST_Role.CreatedOn,106) AS createdOn ,      
--_t2.FirstName AS modifiedBy, CONVERT(VARCHAR,MST_Role.ModifiedOn,106)  AS modifiedOn       
--FROM MST_Role as MST_Role     
      
--LEFT JOIN MST_User  ON MST_User.UserId = MST_Role.CreatedBy      
--left JOIN MST_User _t2 ON _t2.UserId = MST_Role.ModifiedBy      
-- WHERE MST_Role.IsActive=1  and MST_Role.IsEnabled =1    
END