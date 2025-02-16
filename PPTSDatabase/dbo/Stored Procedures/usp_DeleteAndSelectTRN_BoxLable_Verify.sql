-- =============================================  
-- Author: Jayant Satkar
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
create PROCEDURE [dbo].[usp_DeleteAndSelectTRN_BoxLable_Verify]  
 @PartConfigID nvarchar(50),  
 @UniqueID nvarchar(50)  
AS  
BEGIN  
  SET NOCOUNT ON;  
 BEGIN TRY  
  Begin transaction   
  
  create table #TempTRN_BoxLable_Verify  
  (  
   PartConfig_Id bigint ,  
   PartActualQty bigint ,  
   MachineId bigint ,  
   created_By bigint ,  
   BoschPartNo nvarchar(21) ,  
   PartBatchCode nvarchar(20) ,  
   PartSerialNo varchar(50) ,  
     
  )  
  insert into #TempTRN_BoxLable_Verify  
  select PartConfig_Id , PartActualQty , MachineId, created_By, BoschPartNo , PartBatchCode , PartSerialNo  from [dbo].[TRN_BoxLable_Verify] where PartConfig_Id = @PartConfigID and Code=@UniqueID  
    
    
  delete from TRN_BoxLable_Verify where PartConfig_Id = @PartConfigID and Code = @UniqueID  
  
  select PartConfig_Id, PartActualQty, MachineId, created_By, BoschPartNo, PartBatchCode, PartSerialNo from #TempTRN_BoxLable_Verify  
       
  
  
commit  
  
    END TRY  
 BEGIN CATCH  
 SET NOCOUNT ON;  
  rollback;  
  select 0   
  INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME)  
  SELECT ERROR_PROCEDURE(),  
     ERROR_LINE(),  
     ERROR_NUMBER(),  
     ERROR_MESSAGE(),  
     CURRENT_TIMESTAMP;  
  
     select 0;  
 END CATCH  
END  
  
