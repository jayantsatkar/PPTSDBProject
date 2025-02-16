    
CREATE PROC [dbo].[usp_GetUsers]      
AS      
BEGIN      
      
     
select U.User_Id AS UserId,
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
     
from     
  MST_User U    
  LEFT JOIN MST_User U1  ON U1.User_Id = U.Created_By      
  LEFT JOIN MST_User U2  ON U2.User_Id = U.Modified_By      
  LEFT JOIN MST_Role R ON R.Role_Id = U.Role_Id    
  --LEFT JOIN MST_Division D ON D.DivisionId = U.DivisionId    
    
WHERE U.IsActive=1      
ORDER BY CASE When U.Modified_On is null then U.Created_On ELSE U.Modified_On END  DESC    
END
