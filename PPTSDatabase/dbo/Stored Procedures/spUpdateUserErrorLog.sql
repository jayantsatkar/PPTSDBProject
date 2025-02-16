-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateUserErrorLog]

@Id	nvarchar(50),
@Approved_By nvarchar(50)

		
AS
BEGIN
	BEGIN TRY
		Begin transaction
		UPDATE [dbo].[UserErrorLog]
   SET 
      [Approved_By] = @Approved_By
      
 WHERE Id = @Id
		 
		   select 1;
		   commit

    END TRY
	BEGIN CATCH
	SET NOCOUNT ON;
		rollback;
		select 0 
		INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME)
		SELECT ERROR_PROCEDURE(),
			  ERROR_LINE(),
			  ERROR_NUMBER(),
			  ERROR_MESSAGE(),
			  CURRENT_TIMESTAMP;

			  select 0;
	END CATCH
END

