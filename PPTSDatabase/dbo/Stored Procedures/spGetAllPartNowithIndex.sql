-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spGetFormsandModuleforUser 
-- Author			: Namdeo
-- Created			: 02/11/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spGetAllPartNowithIndex]
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		
			select PartNo,MST_PartConfiguration_ID from(
			select  '---Select---' as PartNo,0 as MST_PartConfiguration_ID
			union
			select
				MST_PartConfiguration.BoschPart_No+'-'+MST_PartConfiguration.Customer_Index +'-'+ MST_Customer.Customer_Code +'-'+MST_Customer.Customer_Name + '-'+ MST_PartConfiguration.CustPart_No as PartNo,
				MST_PartConfiguration.MST_PartConfiguration_ID
			from
				MST_PartConfiguration inner join MST_Customer
				on MST_PartConfiguration.MST_Customer_ID=MST_Customer.MST_Customer_ID) as temp
				order by MST_PartConfiguration_ID asc


	
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

