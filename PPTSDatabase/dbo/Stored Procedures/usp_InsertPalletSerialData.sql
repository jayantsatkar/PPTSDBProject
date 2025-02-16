  
create PROCEDURE [dbo].[usp_InsertPalletSerialData]    
@Invoice_No varchar(25),    
@PartConfig_Id bigint,    
@InvoiceQty bigint,    
@InvoiceDate varchar(30),    
@MachineId bigint,    
@created_By bigint    
AS    
BEGIN    
    
 SET NOCOUNT ON;    
 BEGIN TRY    
  BEGIN TRANSACTION    
    
   declare @PartQty bigint,      @CustPartNo varchar(25),      @BostchPartNo varchar(25),    
     @PalletBarcode varchar(100),  @PalletSerialNo varchar(10), @PalletBatchCode varchar(20),    
     @CustIndex varchar(10), @Size int, @cust_id bigint, @custAddress varchar(100),    
     @PartDesc varchar(30),@custName varchar(100);    
     set @Size=8    
        
    
    
   select     
    @PartQty=NoOfPartQy_Box,    
    @CustPartNo=CustPart_No,    
    @BostchPartNo=BoschPart_No ,    
    @CustIndex=Customer_Index,    
    @cust_id=MST_Customer_ID,    
    @PartDesc=BoschPart_Desc    
   from     
    MST_PartConfiguration     
   where     
    MST_PartConfiguration_ID=@PartConfig_Id    
    
      
   select @PalletSerialNo=REPLICATE('0',@Size-LEN(RTRIM(CONVERT(varchar(8),PalletSrNo+1)))) + CONVERT(varchar(8),PalletSrNo+1) from PalletSerialNo;    
      
   update  PalletSerialNo set PalletSrNo=(PalletSrNo+1);    
    
   set @PalletSerialNo='P'+@PalletSerialNo;    
    
   set @PalletBatchCode='P'+REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(DD,getdate()))))) + CONVERT(varchar(2),datepart(DD,getdate()))+REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(MM,getdate()))))) + CONVERT(varchar(2),
   datepart(MM,getdate()))    
     +convert(varchar(4),datepart(YYYY,getdate()))+REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(HH,getdate()))))) + CONVERT(varchar(2),datepart(HH,getdate()))+    
    REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(MI,getdate()))))) + CONVERT(varchar(2),datepart(MI,getdate()))    
      
   set @PalletBarcode=@BostchPartNo+'-'+@CustIndex+':'+REPLICATE('0',5-LEN(RTRIM(CONVERT(varchar(5),@InvoiceQty))))+CONVERT(varchar(5),@InvoiceQty)+':'    
       +@PalletBatchCode+':'+REPLICATE('0',5-LEN(RTRIM(CONVERT(varchar(5),@PartQty))))+CONVERT(varchar(5),@PartQty)+':'+@PalletSerialNo;    
    
   insert into TRN_PalletSerialNo    
    (    
    Invoice_No,    
    InvoiceQty,    
    PalletSrNo,    
    PalletBatchCode,    
    PalletBarcode,    
    InvoiceDate,    
    Machine_ID,    
    Created_By,    
    Created_On    
    )    
   values    
    (    
    @Invoice_No,    
    @InvoiceQty,    
    @PalletSerialNo,    
    @PalletBatchCode,    
    @PalletBarcode,    
    @InvoiceDate,    
    @MachineId,    
    @created_By,    
    getdate()    
    )    
    
   if( @@IDENTITY >0)    
   begin    
    select @custAddress=(Address_Line1+', '+Address_Line2),  
   
 @custName=Customer_Name  -- @custName Added By Jayant Satkar   
   
 from MST_Customer where MST_Customer_ID=@cust_id;    
     
   
 select 1 as result,  
 TRN_PalletSerialNo_id,  
 @PalletBarcode as PalletSrNo,     
    CONVERT(varchar(20), Created_On,113 ) as Created_On,  
 @custAddress as CustAddress,    
    @PartDesc as partdesc   ,  
   
 ---Below Fields added by Jayant Satkar  
 @custName AS CustomerName,  
 @CustPartNo AS CustPartNo  
    from TRN_PalletSerialNo     
    where TRN_PalletSerialNo_id=@@IDENTITY    
    --select 1 as result,@@IDENTITY as TRN_PalletSerialNo_id;    
    
   end    
   else    
   begin    
    select 0 as result,0 as TRN_PalletSerialNo_id, '' as PalletSrNo,'' as Created_On , '' as CustAddress, '' as partdesc;    
   end    
       
    
  commit;    
    
     
 END TRY    
 BEGIN CATCH    
 SET NOCOUNT ON;    
  rollback;    
  select 0 as result,0 as TRN_PalletSerialNo_id, '' as PalletSrNo,'' as Created_On, '' as CustAddress, '' as partdesc;    
  INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME)    
  SELECT ERROR_PROCEDURE(),    
     ERROR_LINE(),    
     ERROR_NUMBER(),    
     ERROR_MESSAGE(),    
     CURRENT_TIMESTAMP;    
 END CATCH    
END    
