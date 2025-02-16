

CREATE VIEW [dbo].[vw_TRN_ScanPartBarcode]
AS
SELECT        dbo.HST_TRN_ScanPartBarcode.TRN_ScanPartBarcode_ID, dbo.HST_TRN_ScanPartBarcode.PartBarcode, dbo.HST_TRN_ScanPartBarcode.PartSerialNo, 
                         dbo.HST_TRN_ScanPartBarcode.Machine_ID, dbo.HST_TRN_ScanPartBarcode.Created_By, dbo.HST_TRN_ScanPartBarcode.Created_On, 
                         dbo.HST_TRN_ScanPartBarcode.Modified_By, dbo.HST_TRN_ScanPartBarcode.Modified_On
FROM            dbo.HST_TRN_ScanPartBarcode with(nolock)
union all
     SELECT        dbo.TRN_ScanPartBarcode.TRN_ScanPartBarcode_ID, dbo.TRN_ScanPartBarcode.PartBarcode, dbo.TRN_ScanPartBarcode.PartSerialNo, 
                         dbo.TRN_ScanPartBarcode.Machine_ID, dbo.TRN_ScanPartBarcode.Created_By, dbo.TRN_ScanPartBarcode.Created_On, 
                         dbo.TRN_ScanPartBarcode.Modified_By, dbo.TRN_ScanPartBarcode.Modified_On
FROM            dbo.TRN_ScanPartBarcode with(nolock)


