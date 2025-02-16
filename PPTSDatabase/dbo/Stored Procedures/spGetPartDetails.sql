-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spGetFormsandModuleforUser 
-- Author			: Namdeo
-- Created			: 02/11/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spGetPartDetails]
	@pPartConfiguration_Id bigint
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		
		-- to get models and its forms
			select
				MST_PartConfiguration.NoOfPartQy_Box, 
				MST_PartConfiguration.BoschPart_No,
				MST_PartConfiguration.BoschPart_Desc,
				MST_PartConfiguration.CustPart_No,
				MST_Customer.Customer_Code,
				MST_Customer.Customer_Name,
				MST_Customer.Customer_Index 
			from 
				MST_PartConfiguration,
				MST_Customer 
			where 
				MST_PartConfiguration.MST_Customer_ID=MST_Customer.MST_Customer_ID
				and  MST_PartConfiguration_ID=@pPartConfiguration_Id




	
	END TRY
	BEGIN CATCH
	SET NOCOUNT ON;
		INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME)
		SELECT ERROR_PROCEDURE(),
			  ERROR_LINE(),
			  ERROR_NUMBER(),
			  ERROR_MESSAGE(),
			  CURRENT_TIMESTAMP;
	END CATCH
END

