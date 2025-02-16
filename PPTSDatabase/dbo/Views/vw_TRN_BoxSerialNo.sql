

CREATE VIEW [dbo].[vw_TRN_BoxSerialNo]
AS
SELECT        dbo.TRN_BoxSerialNo.TRN_BoxSerialNo_ID, dbo.TRN_BoxSerialNo.MST_PartConfiguration_ID,
						dbo.TRN_BoxSerialNo.BoxSerial_No, dbo.TRN_BoxSerialNo.BoxBatchCode,
						 dbo.TRN_BoxSerialNo.BoxBarcode, dbo.TRN_BoxSerialNo.ActualPart_Qty,
                         dbo.TRN_BoxSerialNo.Machine_ID, dbo.TRN_BoxSerialNo.Created_By, dbo.TRN_BoxSerialNo.Created_On, 
                         dbo.TRN_BoxSerialNo.Modified_By, dbo.TRN_BoxSerialNo.Modified_On
FROM            dbo.TRN_BoxSerialNo with(nolock)
UNION ALL
SELECT        dbo.HST_TRN_BoxSerialNo.TRN_BoxSerialNo_ID,  dbo.HST_TRN_BoxSerialNo.MST_PartConfiguration_ID,
						dbo.HST_TRN_BoxSerialNo.BoxSerial_No,  dbo.HST_TRN_BoxSerialNo.BoxBatchCode,
						dbo.HST_TRN_BoxSerialNo.BoxBarcode, dbo.HST_TRN_BoxSerialNo.ActualPart_Qty,
                         dbo.HST_TRN_BoxSerialNo.Machine_ID, dbo.HST_TRN_BoxSerialNo.Created_By, dbo.HST_TRN_BoxSerialNo.Created_On, 
                         dbo.HST_TRN_BoxSerialNo.Modified_By, dbo.HST_TRN_BoxSerialNo.Modified_On
FROM            dbo.HST_TRN_BoxSerialNo with (nolock)

