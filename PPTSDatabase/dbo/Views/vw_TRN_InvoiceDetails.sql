


CREATE VIEW [dbo].[vw_TRN_InvoiceDetails]
AS

SELECT        dbo.TRN_InvoiceDetails.TRN_InvoiceDetails_ID, dbo.TRN_InvoiceDetails.InvoiceNo, 
						 dbo.TRN_InvoiceDetails.PalletSerial_No,
						 dbo.TRN_InvoiceDetails.TRN_PalletSerialNo_ID,
                         dbo.TRN_InvoiceDetails.BoxSerialNo, dbo.TRN_InvoiceDetails.TRN_BoxSerialNo_ID, dbo.TRN_InvoiceDetails.BoxBatchCode, 
						 dbo.TRN_InvoiceDetails.Pallet_Qty, dbo.TRN_InvoiceDetails.Machine_ID, 
                         dbo.TRN_InvoiceDetails.Created_By, dbo.TRN_InvoiceDetails.Created_On, dbo.TRN_InvoiceDetails.Modified_By, 
                         dbo.TRN_InvoiceDetails.Modified_On
FROM            dbo.TRN_InvoiceDetails with(nolock)
UNION ALL
SELECT        dbo.HST_TRN_InvoiceDetails.TRN_InvoiceDetails_ID, dbo.HST_TRN_InvoiceDetails.InvoiceNo, 
						 dbo.HST_TRN_InvoiceDetails.PalletSerial_No,		
						 dbo.HST_TRN_InvoiceDetails.TRN_PalletSerialNo_ID,
                         dbo.HST_TRN_InvoiceDetails.BoxSerialNo, dbo.HST_TRN_InvoiceDetails.TRN_BoxSerialNo_ID, dbo.HST_TRN_InvoiceDetails.BoxBatchCode, 
						 dbo.HST_TRN_InvoiceDetails.Pallet_Qty, dbo.HST_TRN_InvoiceDetails.Machine_ID, 
                         dbo.HST_TRN_InvoiceDetails.Created_By, dbo.HST_TRN_InvoiceDetails.Created_On, dbo.HST_TRN_InvoiceDetails.Modified_By, 
                         dbo.HST_TRN_InvoiceDetails.Modified_On
FROM            dbo.HST_TRN_InvoiceDetails with(nolock)





