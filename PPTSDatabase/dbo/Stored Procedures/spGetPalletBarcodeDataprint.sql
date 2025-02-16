-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spGetInvoiceReport 
-- Author			: Namdeo
-- Created			: 25/11/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spGetPalletBarcodeDataprint]
@SerialNo as varchar(10),
@FlagforPalletorBox as bigint

AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		
		
			
			select 
				distinct
				MST_Customer.Customer_Name, MST_PartConfiguration.BoschPart_No+'-'+MST_PartConfiguration.Customer_Index as BoschPart_No,
				MST_PartConfiguration.NoOfPartQy_Box,TRN_PalletSerialNo.PalletSrNo,
				MST_PartConfiguration.BoschPart_Desc, CONVERT(varchar(20), TRN_PalletSerialNo.Created_On,113 ) as createdon,
				MST_Customer.Address_Line1+',' +MST_Customer.Address_Line2 as custaddress,
				MST_PartConfiguration.CustPart_No,TRN_InvoiceDetails.InvoiceNo,
				TRN_PalletSerialNo.InvoiceQty,TRN_PalletSerialNo.InvoiceDate,
				TRN_PalletSerialNo.PalletBarcode
			from 
			TRN_PalletSerialNo,
			MST_Customer,
			MST_PartConfiguration,
			TRN_InvoiceDetails,
			TRN_BoxSerialNo
			where TRN_PalletSerialNo.TRN_PalletSerialNo_ID=TRN_InvoiceDetails.TRN_PalletSerialNo_ID
			and TRN_InvoiceDetails.TRN_BoxSerialNo_ID=TRN_BoxSerialNo.TRN_BoxSerialNo_ID
			and TRN_BoxSerialNo.MST_PartConfiguration_ID=MST_PartConfiguration.MST_PartConfiguration_ID
			and MST_PartConfiguration.MST_Customer_ID=MST_Customer.MST_Customer_ID
			and TRN_PalletSerialNo.PalletSrNo=@SerialNo

		
			
	
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

