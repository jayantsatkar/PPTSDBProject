 

  
CREATE PROC [dbo].[usp_CheckRoleWithUser]  
@Id int 
AS  
BEGIN  
  Declare @Exist bit  
  Declare @Count int

  SELECT  @Count = 
		(SELECT  COUNT(*) from MST_User
		INNER JOIN MST_Role ON MST_Role.Role_Id = MST_User.Role_ID 
		WHERE MST_User.IsActive=1 and MST_User.Role_ID = @Id)
  
  IF @Count > 0
  BEGIN
   SET @Exist =1  
  END
  ELSE
  BEGIN 
   SET @Exist =0
  END

  
          
   select @Exist  
END


