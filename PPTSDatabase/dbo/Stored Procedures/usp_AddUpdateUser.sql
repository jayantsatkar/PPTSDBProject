  
CREATE PROC [dbo].[usp_AddUpdateUser]        
@UserId INT,        
@RollId INT,        
@EmployeeId nvarchar(50),        
@LoginId VARCHAR(50),        
@Password VARCHAR(200),        
@FirstName NVARCHAR(50),        
@LastName NVARCHAR(50) ,        
@MobileNo VARCHAR(50) ,        
@EmailId VARCHAR(50),        
@Address NVARCHAR(200)=null,           
@IsActive BIT,        
@CreatedBy INT=1,        
@ModifiedBy INT = null    
         
AS        
BEGIN        
IF(@UserId =0)        
BEGIN        
INSERT INTO MST_User(Role_Id, EmployeeId, Login_ID,[Password],First_Name,Last_Name,Mobile_No,EmailId,[Address],         IsActive, Created_By, Created_On )        
SELECT @RollId, @EmployeeId,@LoginId,@Password,@FirstName,@LastName,@MobileNo,@EmailId,@Address,        
@IsActive,@CreatedBy,GETDATE()        
        
SELECT SCOPE_IDENTITY()         
        
END        
        
ELSE        
        
BEGIN        
         IF(@Password ='')        
   BEGIN        
      UPDATE MST_User SET         
             Role_Id = @RollId, EmployeeId=@EmployeeId,Login_Id=@LoginId,        
             First_Name=@FirstName,Last_Name=@LastName,Mobile_No=@MobileNo,[Address] =@Address,        
             EmailId=@EmailId,      
             IsActive=@IsActive, Modified_By=@CreatedBy ,        
             Modified_On= GETDATE()        
             WHERE User_Id=@UserId        
   END        
   ELSE        
   BEGIN        
             UPDATE MST_User SET         
               Role_Id = @RollId,  EmployeeId=@EmployeeId,Login_Id=@LoginId,[Password] =@Password,        
               First_Name=@FirstName,Last_Name=@LastName,Mobile_No=@MobileNo,[Address] =@Address,        
               EmailId=@EmailId,       
               IsActive=@IsActive, Modified_By=@CreatedBy ,        
               Modified_On= GETDATE()        
              WHERE User_Id=@UserId        
   END     
    
--    IF(@isImgDeleted = 1)    
--    BEGIN    
--     UPDATE MST_User      
-- SET UserImagePath = '' WHERE UserId= @UserID       
--    END    
       
END        
        
END