--usp_CheckRoleDuplicate 1,'SuperAdmin','RoleName'    
CREATE PROC [dbo].[usp_CheckRoleDuplicate]     
@RoleId int =0,    
@FiledValue Nvarchar(200) , -- Value to be checked        
@FeildName varchar(50) -- Column Name        
        
AS        
BEGIN        
  Declare @Exist bit   , @RoleIdSelected int    
  SET @Exist =0        
     BEGIN        
    select @RoleIdSelected = Role_Id from MST_Role where Role_Name = @FiledValue and IsActive = 1    
     
   IF(@RoleId <>@RoleIdSelected)    
      BEGIN        
          SET @Exist =1        
      END         
     END        
       
   select @Exist        
END  