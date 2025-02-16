---==================================================================================                
-- Application      : MES                
-- Object Name                      :[dbo].[usp_GetUsersByPage]   10,10,''             
-- Author                           : VIDHI MORE               
-- Created on                       : 30 NOV,22               
-- Database(s)                      : FM_JEMES                
-- Description                      :                 
-- Modified_On                      :                
-- Modified By                      :                
-- ================================================================================       
CREATE PROC [dbo].[usp_GetUsersByPage]       
@PageNumber INT ,        
@RowsOfPage INT  ,      
@Text VARCHAR(50)     
AS       
BEGIN            
DECLARE @recordsTotal INT , @recordsFiltered INT        
IF OBJECT_ID('TEMPDB..#TEMP') IS NOT NULL        
DROP TABLE #TEMP        
SELECT * INTO #Temp  FROM(      
           
 SELECT      
 (ROW_NUMBER() OVER (ORDER BY CASE When U.Modified_On is null then  U.Created_On ELSE  U.Modified_On END    DESC) ) AS SeqNumber ,       
 U.[User_Id] AS UserId ,R.Role_Name AS RoleName, 
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
 U1.Login_Id AS createdBy, 
 FORMAT(U.Created_On,'dd-MM-yyyy HH:mm:ss') AS createdOn ,            
U2.Login_Id AS modifiedBy, 
FORMAT(U.Modified_On,'dd-MM-yyyy HH:mm:ss') AS modifiedOn             
           
 from           
  MST_User U          
  LEFT JOIN MST_User U1  ON U1.User_Id = U.Created_By            
  LEFT JOIN MST_User U2  ON U2.User_Id = U.Modified_By            
  LEFT JOIN MST_Role R ON R.Role_Id = U.Role_Id          
 -- LEFT JOIN MST_Division D ON D.DivisionId = U.DivisionId          
          
WHERE U.IsActive=1 )us           
WHERE (@Text='' OR  FirstName LIKE  '%'+@Text+'%')     
OR  (@Text='' OR LoginId LIKE  '%'+@Text+'%')     
OR  (@Text='' OR EmailId LIKE  '%'+@Text+'%')     
OR  (@Text='' OR LastName LIKE  '%'+@Text+'%')       
OR  (@Text='' OR RoleName LIKE  '%'+@Text+'%')       
--OR  (@Text='' OR  Comment  LIKE  '%'+@Text+'%')     
OR  (@Text='' OR MobileNo LIKE  '%'+@Text+'%')      
--OR  (@Text='' OR EmailId LIKE  '%'+@Text+'%')      
OR  (@Text='' OR createdBy LIKE  '%'+@Text+'%')
OR  (@Text='' OR modifiedBy LIKE  '%'+@Text+'%')   
OR  (@Text='' OR CONVERT(VARCHAR,ModifiedOn,106) LIKE '%'+@Text+'%')  
OR  (@Text='' OR CONVERT(VARCHAR,createdOn,106) LIKE '%'+@Text+'%')  
OR  (@Text='' OR EmployeeId LIKE '%'+@Text+'%')  
ORDER BY SeqNumber        
SELECT  @recordsTotal =  @@ROWCOUNT,  @recordsFiltered = @@ROWCOUNT        
IF  EXISTS (SELECT 1 FROM #Temp)        
BEGIN        
SELECT     @recordsTotal AS recordsTotal , @recordsFiltered AS recordsFiltered , * FROM #Temp        
ORDER BY SeqNumber ASC        
        
OFFSET @PageNumber ROWS          
FETCH NEXT @RowsOfPage ROWS ONLY          
end        
ELSE        
BEGIN        
SELECT  0 AS recordsTotal , 0 AS recordsFiltered        
END        
        
END