
CREATE PROC [dbo].[usp_CheckUserDuplicate]    
@UserId int=0,    
@FiledValue varchar(50),    
@FeildName varchar(50) =''    
    
AS    
BEGIN    
  Declare @Exist bit    
  Declare @UserIdSelected int    
    
  SET @Exist =0    
        
      IF(LOWER(@FeildName) = 'loginid')    
     BEGIN    
         --IF EXISTS (select UserId from MST_User where LoginId = @FiledValue)    
      select  @UserIdSelected  = User_Id from MST_User where Login_Id = @FiledValue and IsActive=1    
      IF(@UserId <>@UserIdSelected)    
      BEGIN    
          
          SET @Exist =1    
          
      END     
     END    
   IF(LOWER(@FeildName) = 'emailid')    
     BEGIN    
         --IF EXISTS (select EmailId from MST_User where EmailId = @FiledValue)    
     select @UserIdSelected =  User_Id from MST_User where EmailId = @FiledValue and IsActive=1    
      IF(@UserId <>@UserIdSelected)    
      BEGIN    
          SET @Exist =1    
      END     
     END    
   IF(LOWER(@FeildName) = 'employeeid')    
     BEGIN    
         --IF EXISTS (select EmployeeId from MST_User where EmployeeId = @FiledValue)    
      select  @UserIdSelected =  User_Id from MST_User where EmployeeId = @FiledValue and IsActive=1    
      IF(@UserId <>@UserIdSelected)    
      BEGIN    
          SET @Exist =1    
      END     
     END    
       
   select @Exist    
END

