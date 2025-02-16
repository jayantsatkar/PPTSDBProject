
  
CREATE PROCEDURE [dbo].[USP_CHECKPARTNOSCANED]  
--DECLARE 
@SCANNEDBARCODE VARCHAR(50),
@PartNo VARCHAR(50)

/*

[USP_CHECKPARTNOSCANED] 'EH7C23574008','0204834008'

*/  
AS  

--SELECT @SCANNEDBARCODE ='WA1A41704013',@PartNo='0204834013'
BEGIN  
  
 SET NOCOUNT ON;  
 BEGIN TRY  
  
--SET @SCANNEDBARCODE='EH7C23574008'
DECLARE @BatchCode VARCHAR(4),@PartSerialNumber VARCHAR(4), @PartTypeNumber VARCHAR(4)

IF (LEN(@SCANNEDBARCODE)=12)
BEGIN

SELECT @BatchCode=SUBSTRING(@SCANNEDBARCODE,1,4),@PartSerialNumber=SUBSTRING(@SCANNEDBARCODE,5,4),@PartTypeNumber=SUBSTRING(@SCANNEDBARCODE,9,4)

-- SELECT [dbo].[DecryptDMCBatchCode] (@BatchCode) as BATCH,@PartSerialNumber as PartSerialNumber, @PartTypeNumber as PartTypeNumber
--SELECT * FROM VW_TRN_BOXBARCODEDETAILS WHERE PartBatchCode=[dbo].[DecryptDMCBatchCode] (@BatchCode) AND SUBSTRING(Boschpart_No,LEN(Boschpart_No)-3,4) =@PartTypeNumber AND SUBSTRING(PartSerialNo,LEN(PartSerialNo)-3,4) =@PartSerialNumber
--AND SUBSTRING(@SCANNEDBARCODE,LEN(@SCANNEDBARCODE)-3,4) = SUBSTRING(@PartNo,LEN(@PartNo)-3,4)

IF NOT EXISTS (SELECT 1 FROM VW_TRN_BOXBARCODEDETAILS WHERE PartBatchCode=[dbo].[DecryptDMCBatchCode] (@BatchCode) 
AND SUBSTRING(Boschpart_No,LEN(Boschpart_No)-3,4) =@PartTypeNumber 
AND SUBSTRING(PartSerialNo,LEN(PartSerialNo)-3,4) =@PartSerialNumber)
--AND SUBSTRING(@SCANNEDBARCODE,LEN(@SCANNEDBARCODE)-3,4) = SUBSTRING(@PartNo,LEN(@PartNo)-3,4))  

  BEGIN  
   --SELECT 1 AS RESULT  
   --SELECT 1 AS RESULT,Boschpart_No As PartNo,PartBatchCode , PartSerialNo FROM VW_TRN_BOXBARCODEDETAILS 
   --WHERE PartBatchCode=[dbo].[DecryptDMCBatchCode] (@BatchCode) AND SUBSTRING(Boschpart_No,LEN(Boschpart_No)-3,4) =@PartTypeNumber AND SUBSTRING(PartSerialNo,LEN(PartSerialNo)-3,4) =@PartSerialNumber

SELECT 1 AS RESULT  ,[dbo].[DecryptDMCBatchCode] (@BatchCode) as PartBatchCode, @PartSerialNumber as PartSerialNo, @PartTypeNumber as PartNo

  END  
  ELSE  
  
  BEGIN  
  -- SELECT 0 AS RESULT  

   SELECT 0 AS RESULT, '' AS	PartNo,''AS 	PartBatchCode	,'' AS PartSerialNo

  END 
  
END   
 END TRY  
 BEGIN CATCH  
   
  INSERT INTO ERRORLOG(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME)  
  SELECT ERROR_PROCEDURE(),       ERROR_LINE(),       ERROR_NUMBER(),       ERROR_MESSAGE(),       CURRENT_TIMESTAMP;  
  
 END CATCH  
END  
  
