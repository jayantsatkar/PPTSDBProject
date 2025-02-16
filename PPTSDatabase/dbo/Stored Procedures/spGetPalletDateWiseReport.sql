-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spPalletWiseReport 
-- Author			: Namdeo
-- Created			: 25/11/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spGetPalletDateWiseReport]
@fromDate as datetime,
@toDate as datetime
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY

			select 
				ROW_NUMBER() over(order by vw_TRN_InvoiceDetails.PalletSerial_No) as SrNo,
				vw_TRN_BoxBarcodeDetails.BoxSerialNo,
				vw_TRN_BoxBarcodeDetails.BoxBatchCode,
				vw_TRN_BoxBarcodeDetails.Boschpart_No,
				vw_TRN_BoxBarcodeDetails.PartSerialNo,
				vw_TRN_BoxBarcodeDetails.PartBatchCode
			from
				vw_TRN_InvoiceDetails inner join vw_TRN_BoxSerialNo
				on vw_TRN_InvoiceDetails.TRN_BoxSerialNo_ID=vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID
				inner join vw_TRN_BoxBarcodeDetails 
				on vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID=vw_TRN_BoxBarcodeDetails.TRN_BoxSerialNo_ID
				inner join vw_TRN_PalletSerialNo 
				on vw_TRN_PalletSerialNo.TRN_PalletSerialNo_ID=vw_TRN_InvoiceDetails.TRN_PalletSerialNo_ID
			where 
				vw_TRN_InvoiceDetails.Created_On between @fromDate and @toDate
			order by 
				vw_TRN_InvoiceDetails.PalletSerial_No,vw_TRN_BoxBarcodeDetails.BoxSerialNo,vw_TRN_BoxBarcodeDetails.PartSerialNo ;

				


	
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

