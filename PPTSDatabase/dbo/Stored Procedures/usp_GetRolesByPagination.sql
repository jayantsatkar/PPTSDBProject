 
CREATE PROC [dbo].[usp_GetRolesByPagination] --10,1,''   
@PageSize INT =10,
@PageNumber INT = 1,
@Text VARCHAR(50)   =''
AS        
BEGIN        
        
IF OBJECT_ID('TEMPDB..#Temp') IS NOT NULL
DROP TABLE #Temp
DECLARE @TotalRowCount INT 

SELECT MST_Role.Role_Id AS roleId , 
Role_Name AS roleName,        
Role_Desc AS roleDesc, 
MST_User.First_Name AS createdBy, 
FORMAT( MST_Role.Created_On,'dd-MM-yyyy HH:mm:ss') AS createdOn,        
_t2.First_Name AS modifiedBy,
FORMAT( MST_Role.Modified_On,'dd-MM-yyyy HH:mm:ss')  AS modifiedOn,  
MST_User.First_Name+' '+MST_User.Last_Name AS createdByEx, 
CONVERT(VARCHAR,MST_Role.Created_On,9) AS createdOnEx ,        
_t2.First_Name+' '+ _t2.Last_Name AS modifiedByEx, 
CONVERT(VARCHAR,MST_Role.Modified_On,9)  AS modifiedOnEx,
MST_Role.IsActive
INTO #Temp 
FROM MST_Role as MST_Role       
        
LEFT JOIN MST_User  ON MST_User.User_Id = MST_Role.Created_By        
LEFT JOIN MST_User _t2 ON _t2.User_Id = MST_Role.Modified_By        
WHERE MST_Role.IsActive=1   AND (Role_Name LIKE '%'+@Text+'%' OR @Text = '')

SELECT @TotalRowCount = @@ROWCOUNT;

SELECT @TotalRowCount AS [TotalRowCount] , *
FROM #Temp 
ORDER BY CASE When ModifiedOn is null then CreatedOn ELSE ModifiedOn END  DESC      

 OFFSET @PageNumber ROWS    
 FETCH NEXT @PageSize ROWS ONLY  
END
GO
