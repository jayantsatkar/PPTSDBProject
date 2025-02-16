-- =============================================
-- Author     :		
-- Create date: 24/04/2018
-- Description:	Used to get the customer and bosch part no relation
-- created By: 
-- =============================================
CREATE PROCEDURE [dbo].[spGetBoschPartNoFromCustPartNo] 
	@custPartNo varchar(100),
	@kanbanId varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		  SELECT Bosch_PartNo,Customer_PartNo,Kanban_ID FROM MST_Cust_Bosch_PartNo_Rel
		  WHERE Customer_PartNo = @custPartNo AND Kanban_ID = @kanbanId
	END TRY
	BEGIN CATCh
	SET NOCOUNT ON;
		INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME,ERROR_TYPE)
		SELECT ERROR_PROCEDURE(),
			  ERROR_LINE(),
			  ERROR_NUMBER(),
			  ERROR_MESSAGE(),
			  CURRENT_TIMESTAMP,'E';
	END CATCH	
END

