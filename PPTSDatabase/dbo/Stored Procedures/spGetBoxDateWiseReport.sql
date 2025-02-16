-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spGetInvoiceReport 
-- Author			: Namdeo
-- Created			: 25/11/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spGetBoxDateWiseReport]
@FromDate as datetime,
@toDate as datetime
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		
			select 
				ROW_NUMBER() over(order by vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID) as SrNo,
				vw_TRN_BoxBarcodeDetails.Boschpart_No,
				vw_TRN_BoxBarcodeDetails.PartSerialNo,
				vw_TRN_BoxBarcodeDetails.PartBatchCode
			from
				 vw_TRN_BoxSerialNo inner join vw_TRN_BoxBarcodeDetails 
				on vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID=vw_TRN_BoxBarcodeDetails.TRN_BoxSerialNo_ID
			where 
				vw_TRN_BoxSerialNo.Created_On between @FromDate and @toDate
			order by 
				vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID,vw_TRN_BoxBarcodeDetails.PartSerialNo ;

			
	
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

