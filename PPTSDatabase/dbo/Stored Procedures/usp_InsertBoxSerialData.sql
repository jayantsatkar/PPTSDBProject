  
CREATE PROCEDURE [dbo].[usp_InsertBoxSerialData]    
@PartConfig_Id bigint,    
@PartActualQty bigint,    
@MachineId bigint,    
@created_By bigint    
AS    
BEGIN    
    
 SET NOCOUNT ON;    
 BEGIN TRY    
  Begin transaction    
    
   declare @PartQty bigint,    
     @CustPartNo varchar(25),    
     @BostchPartNo varchar(25),    
     @BoxBarcode varchar(50),    
     @BoxSerialNo varchar(10),    
     @BoxBatchCode varchar(20),    
     @CustIndex varchar(10),    
     @Size int,  
  @PartDesc VARCHAR(10),  
  @Customer_Name VARCHAR(40);    
    
     set @Size=8    
        
    
    
   select     
    @PartQty=NoOfPartQy_Box,    
    @CustPartNo=CustPart_No,    
    @BostchPartNo=BoschPart_No ,    
    @CustIndex=Customer_Index ,  
  
-- Part Desc and Cutomer Name Add  
 @PartDesc = BoschPart_Desc  
   from     
    MST_PartConfiguration     
   where     
    MST_PartConfiguration_ID=@PartConfig_Id    
    
  
   select top 1 @Customer_Name= Customer_Name from MST_Customer  where  Customer_Index=@CustIndex  
      
   select @BoxSerialNo=REPLICATE('0',@Size-LEN(RTRIM(CONVERT(varchar(8),BoxSerialNo+1)))) + CONVERT(varchar(8),BoxSerialNo+1) from BoxSerialNo;    
      
   update  BoxSerialNo set BoxSerialNo=(BoxSerialNo+1);    
    
   set @BoxSerialNo='B'+@BoxSerialNo;    
          
    
   set @BoxBatchCode='B'+REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(DD,getdate()))))) + CONVERT(varchar(2),datepart(DD,getdate()))+REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(MM,getdate()))))) + CONVERT(varchar(2),datepart(MM,getdate(
  
)))    
     +convert(varchar(4),datepart(YYYY,getdate()))+REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(HH,getdate()))))) + CONVERT(varchar(2),datepart(HH,getdate()))+    
    REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(MI,getdate()))))) + CONVERT(varchar(2),datepart(MI,getdate()))    
      
   set @BoxBarcode=@BostchPartNo+'-'+@CustIndex+':'+ REPLICATE('0',3-LEN(RTRIM(CONVERT(varchar(3),@PartActualQty))))+CONVERT(varchar(3),@PartActualQty)+':'    
       +@BoxBatchCode+':'+@BoxSerialNo;    
    
   insert into TRN_BoxSerialNo(MST_PartConfiguration_ID,BoxBatchCode,BoxSerial_No,BoxBarcode,ActualPart_Qty,Machine_ID,Created_By,Created_On)    
   values(@PartConfig_Id,@BoxBatchCode,@BoxSerialNo,@BoxBarcode,@PartActualQty,@MachineId,@created_By,getdate())    
    
   if( @@IDENTITY >0)    
   begin    
    select     
     1 as result,TRN_BoxSerialNo_ID,@BoxBarcode as BoxSerial_No,CONVERT(varchar(20), Created_On,113 ) as Created_On,  
  ---Parameters Added By Jayant Satkar  
  
  @PartDesc AS PartDesc,  
  @Customer_Name AS CustomerName  
  
    from     
     TRN_BoxSerialNo where TRN_BoxSerialNo_ID=@@IDENTITY;    
    --select 1 as result,@@IDENTITY as TRN_BoxSerialNo_ID;    
    
   end    
   else    
   begin    
    select 0 as result,0 as TRN_BoxSerialNo_ID,'' as BoxSerial_No,'' as Created_On;    
   end    
       
    
  commit;    
    
     
 END TRY    
 BEGIN CATCH    
 SET NOCOUNT ON;    
  rollback;    
  select 0 as result,0 as TRN_BoxSerialNo_ID,'' as BoxSerial_No, '' as Created_On;    
  INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME)    
  SELECT ERROR_PROCEDURE(),    
     ERROR_LINE(),    
     ERROR_NUMBER(),    
     ERROR_MESSAGE(),    
     CURRENT_TIMESTAMP;    
 END CATCH    
END    
