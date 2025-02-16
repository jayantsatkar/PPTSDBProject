-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spGetInvoiceReport 
-- Author			: Namdeo
-- Created			: 25/11/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spGetBoxSerialNoReport]
@BoSrNoNo as varchar(10),
@FromDate as datetime,
@toDate as datetime,
@Datewisereport as bit
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		if(@Datewisereport=0 and @BoSrNoNo<>'')
		begin
			select 
				ROW_NUMBER() over(order by vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID) as SrNo,
				vw_TRN_InvoiceDetails.InvoiceNo,
				vw_TRN_InvoiceDetails.PalletSerial_No,
				vw_TRN_PalletSerialNo.PalletBatchCode,
				vw_TRN_BoxBarcodeDetails.BoxSerialNo,
				vw_TRN_BoxBarcodeDetails.BoxBatchCode,
				(select BoschPart_No from MST_PartConfiguration where MST_PartConfiguration_ID=vw_TRN_BoxBarcodeDetails.MST_PartConfiguration_ID) as Boschpart_No,
				vw_TRN_BoxBarcodeDetails.PartSerialNo,
				vw_TRN_BoxBarcodeDetails.PartBatchCode,
				CONVERT(varchar(20), vw_TRN_BoxSerialNo.Created_On,106 ) as Created_On,
				MST_User.Login_ID
			from
				 vw_TRN_BoxSerialNo inner join vw_TRN_BoxBarcodeDetails 
				on vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID=vw_TRN_BoxBarcodeDetails.TRN_BoxSerialNo_ID
				inner join MST_User
				on vw_TRN_BoxSerialNo.Created_By=MST_User.User_ID
				left join vw_TRN_InvoiceDetails 
				on vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID=vw_TRN_InvoiceDetails.TRN_BoxSerialNo_ID
				left join vw_TRN_PalletSerialNo 
				on vw_TRN_PalletSerialNo.TRN_PalletSerialNo_ID=vw_TRN_InvoiceDetails.TRN_PalletSerialNo_ID
			where 
				vw_TRN_BoxSerialNo.BoxSerial_No=@BoSrNoNo
			order by 
				vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID,vw_TRN_BoxBarcodeDetails.PartSerialNo ;
		end
		else
		begin
			select 
				ROW_NUMBER() over(order by vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID) as SrNo,
				vw_TRN_InvoiceDetails.InvoiceNo,
				vw_TRN_InvoiceDetails.PalletSerial_No,
				vw_TRN_PalletSerialNo.PalletBatchCode,
				vw_TRN_BoxBarcodeDetails.BoxSerialNo,
				vw_TRN_BoxBarcodeDetails.BoxBatchCode,
				(select BoschPart_No from MST_PartConfiguration where MST_PartConfiguration_ID=vw_TRN_BoxBarcodeDetails.MST_PartConfiguration_ID) as Boschpart_No,
				vw_TRN_BoxBarcodeDetails.PartSerialNo,
				vw_TRN_BoxBarcodeDetails.PartBatchCode,
				CONVERT(varchar(20), vw_TRN_BoxSerialNo.Created_On,106 ) as Created_On,
				MST_User.Login_ID
			from
				 vw_TRN_BoxSerialNo inner join vw_TRN_BoxBarcodeDetails 
				on vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID=vw_TRN_BoxBarcodeDetails.TRN_BoxSerialNo_ID
				inner join MST_User
				on vw_TRN_BoxSerialNo.Created_By=MST_User.User_ID
				left join vw_TRN_InvoiceDetails 
				on vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID=vw_TRN_InvoiceDetails.TRN_BoxSerialNo_ID
				left join vw_TRN_PalletSerialNo 
				on vw_TRN_PalletSerialNo.TRN_PalletSerialNo_ID=vw_TRN_InvoiceDetails.TRN_PalletSerialNo_ID
			where 
				vw_TRN_BoxSerialNo.Created_On between @FromDate and @toDate
			order by 
				vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID,vw_TRN_BoxBarcodeDetails.PartSerialNo ;
		end
			
	
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

