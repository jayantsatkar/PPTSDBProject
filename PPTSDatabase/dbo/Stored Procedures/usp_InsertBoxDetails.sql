-- ====================================================================================  
-- Application   : PPTS  
-- Object Name  : spInsertBoxDetailData   
-- Author   : Namdeo  
-- Created   : 17/11/2015  
-- Modified By  : Namdeo Shinde  
-- Modified On  :   
-- Database(s)  : BOSCH_PPTS  
-- ====================================================================================  
  
create PROCEDURE [dbo].[usp_InsertBoxDetails]  
@PartConfig_Id bigint,  
@BoschPartNo varchar(20),  
@TRN_BoxSerialNo_ID bigint,  
@partBatchCode varchar(20),  
@PartSerialNo varchar(10),  
@ActualQty bigint,  
@MachineId bigint,  
@created_By bigint  
AS  
BEGIN  
  
 SET NOCOUNT ON;  
 BEGIN TRY  
  Begin transaction  
  
   declare @BoxSerialNo varchar(10),  
     @BoxBatchCode varchar(50);  
    
   select   
    @BoxSerialNo=BoxSerial_No,  
    @BoxBatchCode=BoxBatchCode  
   from  
    TRN_BoxSerialNo  
   where   
    TRN_BoxSerialNo_ID=@TRN_BoxSerialNo_ID;  
  
      
   insert into   
    TRN_BoxBarcodeDetails  
    (  
     MST_PartConfiguration_ID,  
     TRN_BoxSerialNo_ID,  
     BoxBatchCode,  
     BoxSerialNo,  
     Boschpart_No,  
     PartBatchCode,  
     PartSerialNo,  
     Machine_ID,  
     ActualPart_Qty,  
     Created_By,  
     Created_On  
     )  
     values  
     (  
      @PartConfig_Id,  
      @TRN_BoxSerialNo_ID,  
      @BoxBatchCode,  
      @BoxSerialNo,  
      @BoschPartNo,  
      @partBatchCode,  
      @PartSerialNo,  
      @MachineId,  
      @ActualQty,  
      @created_By,  
      getdate()  
     );  
     
     
   if( @@IDENTITY >0)  
   begin  
    select 1 as result;  
  
   end  
   else  
   begin  
    select 0 as result;  
   end  
     
      
     
    
  
  commit;  
    
  
   
 END TRY  
 BEGIN CATCH  
 SET NOCOUNT ON;  
  rollback;  
  select 0 as result;  
  INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME)  
  SELECT ERROR_PROCEDURE(),  
     ERROR_LINE(),  
     ERROR_NUMBER(),  
     ERROR_MESSAGE(),  
     CURRENT_TIMESTAMP;  
 END CATCH  
END  
  
