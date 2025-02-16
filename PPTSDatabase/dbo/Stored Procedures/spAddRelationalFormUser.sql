-- ====================================================================================
-- Application 		: MES
-- Object Name		: GetTableNameByFormname
-- Author			: Pramod
-- Created on		: 24/07/2011
-- Database(s)		: AtlasCopco
-- Description 		: Add user and form relation 
-- ====================================================================================
CREATE PROCEDURE [dbo].[spAddRelationalFormUser]
	@pUserId bigint,
    @pFormID bigint,
	@pFlagVisible bit,
	@pCreatedBy bigint,
	@pModifiedBy bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
    SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION
    Declare @pSrNo bigint
    set @pSrNo = 0
    
    select @pSrNo = COUNT([USER_ID]) 
		from REL_UserForm
		where [USER_ID] = @pUserId
			and [Frm_Id] = @pFormID
	if(@pSrNo > 0)
	begin
			UPDATE [REL_UserForm]
			   SET [Flag_Visible] = @pFlagVisible
				  ,[Modified_By] = @pCreatedBy
				  ,[Modified_On] = GETDATE()
			 where [USER_ID] = @pUserId
					and [Frm_Id] = @pFormID
	end
	else
	begin
			INSERT INTO [REL_UserForm]
				   ([User_Id]
				   ,[Frm_Id]
				   ,[Flag_Visible]
				   ,[Created_By]
				   ,[Created_On])
			 VALUES
				   (@pUserId
				   ,@pFormID
				   ,@pFlagVisible
				   ,@pCreatedBy
				   ,GETDATE())
	end
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF (XACT_STATE()) = -1
		BEGIN
			ROLLBACK TRANSACTION;
		END;
	SET NOCOUNT ON;
		INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME,ERROR_TYPE)
		SELECT ERROR_PROCEDURE(),
			  ERROR_LINE(),
			  ERROR_NUMBER(),
			  ERROR_MESSAGE(),
			  CURRENT_TIMESTAMP,'E';
	END CATCH

	
END

