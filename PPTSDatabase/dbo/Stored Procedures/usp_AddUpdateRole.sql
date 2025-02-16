CREATE PROC [dbo].[usp_AddUpdateRole]        
@RoleID INT=0,        
@RoleName NVARCHAR(200),        
@RoleCode VARCHAR(50),        
@RoleDesc NVARCHAR(200),        
@IsActive BIT,        
@CreatedBy INT,        
@ModifiedBy INT = NULL  ,      
@IsRoleActive BIT      
        
AS        
BEGIN        
IF(@RoleID =0)        
BEGIN        
INSERT INTO MST_Role ( Role_Name, Role_Desc, IsActive, Created_By, Created_On )        
SELECT  @RoleName, @RoleDesc, @IsActive,@CreatedBy,GETDATE()        
        
SELECT SCOPE_IDENTITY()         
        
END        
        
ELSE        
        
BEGIN   
--DELETE FROM REL_RoleAuthorization WHERE RoleId = @RoleID AND @IsActive = 0

UPDATE MST_Role SET        
--RoleCode = @RoleCode, 
Role_Name=@RoleName, Role_Desc=@RoleDesc, IsActive=@IsActive, Modified_By=@ModifiedBy , Modified_On= GETDATE() --, IsEnabled= @IsRoleActive      
WHERE Role_Id=@RoleID        
END        
        
END
GO
