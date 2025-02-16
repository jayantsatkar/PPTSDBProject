CREATE PROC [dbo].[usp_GetUser]      
@Id INT      
AS      
BEGIN      
      
      
SELECT     
U.User_Id AS UserId,    
U.Role_Id AS RoleId,     
R.Role_Name AS RoleName ,    
U.EmployeeId ,    
U.Login_Id AS LoginId,    
ISNULL(U.First_Name,'') AS [FirstName],    
ISNULL(U.Last_Name,'') AS [LastName],    
ISNULL(U.[Password],'') AS [Password],    
ISNULL(U.Mobile_No,'') AS [MobileNo],    
ISNULL(U.EmailId,'') AS [EmailId],    
--ISNULL(U.Comment,'') AS [Comment],    
ISNULL(U.[Address],'') AS [Address],    
U.IsActive,    
--ISNULL(U.UserImage,null) AS [UserImage],    
--ISNULL(U.UserImagePath,'') AS [UserImagePath],    
U1.Created_By AS [CreatedBy],     
CAST(U1.Created_On AS DATETIME) AS CreatedOn ,    
ISNULL(U2.Modified_By,'') AS [ModifiedBy],    
CAST(U1.Modified_On AS DATETIME) AS ModifiedOn       
FROM MST_User U    
LEFT JOIN MST_User U1 ON U1.[User_ID] = U.Created_By    
LEFT JOIN MST_User U2 ON U1.[User_ID] = U.Modified_By    
INNER JOIN MST_Role R ON U.Role_Id = R.Role_Id     
WHERE U.IsActive=1      
AND U.[User_Id]=@Id      
      
END  
