CREATE PROC [dbo].[usp_GetRole]        
@Id INT        
AS        
BEGIN        
        
        
SELECT Role_Id as RoleId, Role_Name AS RoleName ,IsActive,
Role_Desc AS RoleDesc, Created_By AS CreatedBy,
CAST(Created_On AS DATETIME) AS CreatedOn ,Modified_By AS ModifiedBy, CAST(Modified_On AS DATETIME) AS ModifiedOn FROM MST_Role WHERE IsActive=1        
AND Role_Id=@Id        
        
END