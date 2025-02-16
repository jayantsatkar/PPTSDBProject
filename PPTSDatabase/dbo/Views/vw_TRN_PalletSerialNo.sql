



CREATE VIEW [dbo].[vw_TRN_PalletSerialNo]
AS
SELECT        dbo.HST_TRN_PalletSerialNo.TRN_PalletSerialNo_ID, dbo.HST_TRN_PalletSerialNo.PalletSrNo, 
			  dbo.HST_TRN_PalletSerialNo.InvoiceDate,
			  dbo.HST_TRN_PalletSerialNo.PalletBarcode, dbo.HST_TRN_PalletSerialNo.PalletBatchCode, 
                         dbo.HST_TRN_PalletSerialNo.Machine_ID, dbo.HST_TRN_PalletSerialNo.Created_On, 
						 dbo.HST_TRN_PalletSerialNo.Created_By, 
                         dbo.HST_TRN_PalletSerialNo.Modified_By, dbo.HST_TRN_PalletSerialNo.Modified_On
FROM            dbo.HST_TRN_PalletSerialNo with (nolock)
UNION ALL
SELECT        dbo.TRN_PalletSerialNo.TRN_PalletSerialNo_ID, dbo.TRN_PalletSerialNo.PalletSrNo, 
			  dbo.TRN_PalletSerialNo.InvoiceDate,
			  dbo.TRN_PalletSerialNo.PalletBarcode,  dbo.TRN_PalletSerialNo.PalletBatchCode,
                         dbo.TRN_PalletSerialNo.Machine_ID, dbo.TRN_PalletSerialNo.Created_On, dbo.TRN_PalletSerialNo.Created_By, 
                         dbo.TRN_PalletSerialNo.Modified_By, dbo.TRN_PalletSerialNo.Modified_On
FROM            dbo.TRN_PalletSerialNo with (nolock)




