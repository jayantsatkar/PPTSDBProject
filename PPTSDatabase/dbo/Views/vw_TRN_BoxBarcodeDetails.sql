


CREATE VIEW [dbo].[vw_TRN_BoxBarcodeDetails]
AS
SELECT        dbo.TRN_BoxBarcodeDetails.TRN_BoxBarcodeDetails_ID, dbo.TRN_BoxBarcodeDetails.BoxSerialNo, 
                         dbo.TRN_BoxBarcodeDetails.MST_PartConfiguration_ID,
						 dbo.TRN_BoxBarcodeDetails.BoxBatchCode,
						  dbo.TRN_BoxBarcodeDetails.Boschpart_No, dbo.TRN_BoxBarcodeDetails.ActualPart_Qty, 
                         dbo.TRN_BoxBarcodeDetails.PartBatchCode, dbo.TRN_BoxBarcodeDetails.PartSerialNo, dbo.TRN_BoxBarcodeDetails.Machine_ID, 
                         dbo.TRN_BoxBarcodeDetails.Created_By, dbo.TRN_BoxBarcodeDetails.Created_On, dbo.TRN_BoxBarcodeDetails.Modified_By, 
                         dbo.TRN_BoxBarcodeDetails.Modified_On,dbo.TRN_BoxBarcodeDetails.TRN_BoxSerialNo_ID
FROM            dbo.TRN_BoxBarcodeDetails with(nolock)
UNION ALL
SELECT        dbo.HST_TRN_BoxBarcodeDetails.TRN_BoxBarcodeDetails_ID, dbo.HST_TRN_BoxBarcodeDetails.BoxSerialNo, 
                         dbo.HST_TRN_BoxBarcodeDetails.MST_PartConfiguration_ID, 
						 dbo.HST_TRN_BoxBarcodeDetails.BoxBatchCode,
						 dbo.HST_TRN_BoxBarcodeDetails.Boschpart_No, dbo.HST_TRN_BoxBarcodeDetails.ActualPart_Qty, 
                         dbo.HST_TRN_BoxBarcodeDetails.PartBatchCode, dbo.HST_TRN_BoxBarcodeDetails.PartSerialNo, dbo.HST_TRN_BoxBarcodeDetails.Machine_ID, 
                         dbo.HST_TRN_BoxBarcodeDetails.Created_By, dbo.HST_TRN_BoxBarcodeDetails.Created_On, dbo.HST_TRN_BoxBarcodeDetails.Modified_By, 
                         dbo.HST_TRN_BoxBarcodeDetails.Modified_On,dbo.HST_TRN_BoxBarcodeDetails.TRN_BoxSerialNo_ID

FROM            dbo.HST_TRN_BoxBarcodeDetails with(nolock)



