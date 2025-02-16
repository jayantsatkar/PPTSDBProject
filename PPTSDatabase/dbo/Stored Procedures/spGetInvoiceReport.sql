CREATE PROCEDURE [dbo].[spGetInvoiceReport]
@InvoiceNo as varchar(30),
@fromDate as datetime,
@Todate as Datetime,
@Datewisereport as bit
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY

		
		if(@Datewisereport=0 and @InvoiceNo<>'')
		begin
		
			select 
				ROW_NUMBER() over(order by vw_TRN_InvoiceDetails.InvoiceNo) as SrNo,
				vw_TRN_InvoiceDetails.InvoiceNo,vw_TRN_InvoiceDetails.PalletSerial_No,
				vw_TRN_PalletSerialNo.PalletBatchCode, vw_TRN_BoxBarcodeDetails.BoxSerialNo,
				vw_TRN_BoxBarcodeDetails.BoxBatchCode,
				 (select BoschPart_No from MST_PartConfiguration where MST_PartConfiguration_ID=vw_TRN_BoxBarcodeDetails.MST_PartConfiguration_ID) as Boschpart_No,
				vw_TRN_BoxBarcodeDetails.PartSerialNo,
				vw_TRN_BoxBarcodeDetails.PartBatchCode,
				CONVERT(varchar(20), vw_TRN_PalletSerialNo.Created_On,106 ) as Created_On,
				MST_User.Login_ID
			from
				vw_TRN_InvoiceDetails inner join vw_TRN_BoxSerialNo
				on vw_TRN_InvoiceDetails.TRN_BoxSerialNo_ID=vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID
				inner join vw_TRN_BoxBarcodeDetails 
				on vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID=vw_TRN_BoxBarcodeDetails.TRN_BoxSerialNo_ID
				inner join vw_TRN_PalletSerialNo 
				on vw_TRN_PalletSerialNo.TRN_PalletSerialNo_ID=vw_TRN_InvoiceDetails.TRN_PalletSerialNo_ID
				inner join MST_User
				on vw_TRN_PalletSerialNo.Created_By=MST_User.User_ID
			where 
				vw_TRN_InvoiceDetails.InvoiceNo=@InvoiceNo
			order by 
				vw_TRN_InvoiceDetails.PalletSerial_No,vw_TRN_BoxBarcodeDetails.BoxSerialNo,vw_TRN_BoxBarcodeDetails.PartSerialNo ;
		end
		else 
		begin
			select 
				ROW_NUMBER() over(order by vw_TRN_InvoiceDetails.TRN_InvoiceDetails_ID) as SrNo,
				vw_TRN_InvoiceDetails.InvoiceNo,vw_TRN_InvoiceDetails.PalletSerial_No,
				vw_TRN_PalletSerialNo.PalletBatchCode,vw_TRN_BoxBarcodeDetails.BoxSerialNo,
				vw_TRN_BoxBarcodeDetails.BoxBatchCode,
				(select BoschPart_No from MST_PartConfiguration where MST_PartConfiguration_ID=vw_TRN_BoxBarcodeDetails.MST_PartConfiguration_ID) as Boschpart_No,
				vw_TRN_BoxBarcodeDetails.PartSerialNo,
				vw_TRN_BoxBarcodeDetails.PartBatchCode,
				CONVERT(varchar(20), vw_TRN_PalletSerialNo.Created_On,106 ) as Created_On,
				MST_User.Login_ID
			from
				vw_TRN_InvoiceDetails inner join vw_TRN_BoxSerialNo
				on vw_TRN_InvoiceDetails.TRN_BoxSerialNo_ID=vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID
				inner join vw_TRN_BoxBarcodeDetails 
				on vw_TRN_BoxSerialNo.TRN_BoxSerialNo_ID=vw_TRN_BoxBarcodeDetails.TRN_BoxSerialNo_ID
				inner join vw_TRN_PalletSerialNo 
				on vw_TRN_PalletSerialNo.TRN_PalletSerialNo_ID=vw_TRN_InvoiceDetails.TRN_PalletSerialNo_ID
				inner join MST_User
				on vw_TRN_PalletSerialNo.Created_By=MST_User.User_ID
			where 
				vw_TRN_InvoiceDetails.Created_On between @fromDate and @Todate
			order by 
				vw_TRN_InvoiceDetails.PalletSerial_No,vw_TRN_BoxBarcodeDetails.BoxSerialNo,vw_TRN_BoxBarcodeDetails.PartSerialNo ;

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

