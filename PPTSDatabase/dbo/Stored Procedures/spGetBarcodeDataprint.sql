-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spGetInvoiceReport 
-- Author			: Namdeo
-- Created			: 25/11/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spGetBarcodeDataprint]
@SerialNo as varchar(10),
@FlagforPalletorBox as bigint

AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		
		
			select 
				MST_Customer.Customer_Name,
				MST_PartConfiguration.BoschPart_No+'-'+MST_PartConfiguration.Customer_Index as partNo,
				TRN_BoxSerialNo.ActualPart_Qty,
				TRN_BoxSerialNo.BoxSerial_No,
				MST_PartConfiguration.BoschPart_Desc,
				CONVERT(varchar(20), TRN_BoxSerialNo.Created_On,113 ) as Created_On,
				TRN_BoxSerialNo.BoxBarcode
			from 
				TRN_BoxSerialNo ,MST_PartConfiguration,MST_Customer
			where 
				TRN_BoxSerialNo.MST_PartConfiguration_ID=MST_PartConfiguration.MST_PartConfiguration_ID
				and MST_PartConfiguration.MST_Customer_ID=MST_Customer.MST_Customer_ID
				and TRN_BoxSerialNo.BoxSerial_No=@SerialNo
		
			
	
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

