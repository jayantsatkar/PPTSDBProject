CREATE PROC [dbo].[usp_GetUsersPagination]  
@PageSize INT =10,
@PageNumber INT = 0,
@Text VARCHAR(50)   =''

AS      
BEGIN      
IF(@PageNumber != 0)
SET @PageNumber = @PageNumber -1;        

DECLARE @TotalRowCount INT 

      
IF OBJECT_ID('#TEMPDB..TEMP') is not null
drop table #Temp
     
SELECT U.User_Id AS UserId,
R.Role_Name AS RoleName, 
--D.DivisionName,
U.EmployeeId,
U.Login_Id AS LoginId,
U.First_Name AS FirstName,
U.Last_Name AS LastName,
U.Mobile_No AS MobileNo,
U.EmailId,
--U.Comment,    
U.Address,
U.IsActive,
--U.UserImage,
--U.UserImagePath,
U1.First_Name + ' ' + U1.Last_Name AS createdBy, 
CONVERT(VARCHAR,U.Created_On,9) AS createdOn ,      
U2.First_Name + ' '+U2.Last_Name AS modifiedBy, 
CONVERT(VARCHAR,U.Modified_On,9)  AS modifiedOn      
--COUNT(1) AS TotalRowCount
     INTO #TEMP
FROM     
  MST_User U    
  LEFT JOIN MST_User U1  ON U1.User_Id = U.Created_By      
  LEFT JOIN MST_User U2  ON U2.User_Id = U.Modified_By      
  LEFT JOIN MST_Role R ON R.Role_Id = U.Role_Id    
  --LEFT JOIN MST_Division D ON D.DivisionId = U.DivisionId    
    
WHERE U.IsActive=1      
AND (@Text = '' OR U.[User_Id] LIKE '%'+@Text+'%')
AND (@Text = '' OR R.Role_Name LIKE '%'+@Text+'%') 
AND (@Text = '' OR U.EmployeeId LIKE '%'+@Text+'%') 
AND (@Text = '' OR U.Login_Id LIKE '%'+@Text+'%') 
AND (@Text = '' OR U.First_Name LIKE '%'+@Text+'%') 

--GROUP BY U.[User_Id],R.Role_Name, U.EmployeeId, U.Login_ID, U.First_Name, U.Last_Name, U.Mobile_No, U.EmailId, U.Address, U.IsActive,
--U1.First_Name, U1.Last_Name, U.Created_On-- U1.Created_On, U2.Created_On
ORDER BY CASE When U.Modified_On is null then U.Created_On ELSE U.Modified_On END  DESC    

SELECT * , @@ROWCOUNT AS TotalRowCount FROM #TEMP
ORDER BY CASE When ModifiedOn is null then CreatedOn ELSE ModifiedOn END  DESC      

 OFFSET @PageNumber*@PageSize ROWS                    
FETCH NEXT @PageSize ROWS ONLY        

END