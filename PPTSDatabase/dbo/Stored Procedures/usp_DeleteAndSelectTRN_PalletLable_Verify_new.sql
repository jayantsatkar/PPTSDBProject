-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
--[usp_DeleteAndSelectTRN_PalletLable_Verify_new] '1','id-8i1j0lmma5ir'  
CREATE PROCEDURE [dbo].[usp_DeleteAndSelectTRN_PalletLable_Verify_new]
 @PartConfigID nvarchar(50),    
 @UniqueID nvarchar(50)    
AS    
BEGIN    
  SET NOCOUNT ON;    
 BEGIN TRY    
  Begin transaction     
    
  create table #TempTRN_PalletLable_Verify    
  (    
   Invoice_No varchar(25),    
   PartConfig_Id nchar(10),    
   InvoiceQty bigint,    
   InvoiceDate varchar(30),    
   Machine_ID bigint,    
   Created_By bigint,    
   BoxBatchCode varchar(25),    
   BoxSerialNo nvarchar(10),
   CustomerName     nvarchar(100)
      
  )    
  declare @PartQty bigint,      @CustPartNo varchar(25),      @BostchPartNo varchar(25),    
     @PalletBarcode varchar(100),  @PalletSerialNo varchar(10), @PalletBatchCode varchar(20),    
     @CustIndex varchar(10), @Size int, @cust_id bigint, @custAddress varchar(100),    @InvoiceQty INT,
     @PartDesc varchar(30),@custName varchar(100),@InvoiceNo VARCHAR(20),@InvoiceDate varchar(30);    
     set @Size=8    
  insert into #TempTRN_PalletLable_Verify    
  select Invoice_No , PartConfig_Id , InvoiceQty ,  InvoiceDate , Machine_ID,  PALL.created_By, BoxBatchCode , BoxSerialNo, Customer_Name as  CustomerName from [dbo].[TRN_PalletLable_Verify] AS PALL
  INNER JOIN MST_PartConfiguration AS PART ON PALL.PartConfig_Id=part.MST_PartConfiguration_ID
  INNER JOIN MST_Customer AS CUST ON CUST.MST_Customer_ID=PART.MST_Customer_ID
  where PALL.PartConfig_Id = @PartConfigID and Code=@UniqueID    
  
  select @InvoiceQty = InvoiceQty, @InvoiceNo= Invoice_No , @InvoiceDate=InvoiceDate from #TempTRN_PalletLable_Verify 
        
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
    MST_PartConfiguration_ID=@PartConfigID    
    
      
   select @PalletSerialNo=REPLICATE('0',@Size-LEN(RTRIM(CONVERT(varchar(8),PalletSrNo+1)))) + CONVERT(varchar(8),PalletSrNo+1) from PalletSerialNo;    
      
   update  PalletSerialNo set PalletSrNo=(PalletSrNo+1);    
    
   set @PalletSerialNo='P'+@PalletSerialNo;    
    
   set @PalletBatchCode='P'+REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(DD,getdate()))))) + CONVERT(varchar(2),datepart(DD,getdate()))+REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(MM,getdate()))))) + CONVERT(varchar(2),
   datepart(MM,getdate()))    
     +convert(varchar(4),datepart(YYYY,getdate()))+REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(HH,getdate()))))) + CONVERT(varchar(2),datepart(HH,getdate()))+    
    REPLICATE('0',2-LEN(RTRIM(CONVERT(varchar(2),datepart(MI,getdate()))))) + CONVERT(varchar(2),datepart(MI,getdate()))    
      
   set @PalletBarcode=@BostchPartNo+'-'+@CustIndex+':'+REPLICATE('0',5-LEN(RTRIM(CONVERT(varchar(5),@InvoiceQty))))+CONVERT(varchar(5),@InvoiceQty)+':'    
       +@PalletBatchCode+':'+REPLICATE('0',5-LEN(RTRIM(CONVERT(varchar(5),@PartQty))))+CONVERT(varchar(5),@PartQty)+':'+@PalletSerialNo;    
    declare @palletid int
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
	select top 1 Invoice_No,InvoiceQty,@PalletSerialNo,@PalletBatchCode,@PalletBarcode,InvoiceDate,Machine_ID,Created_By,getdate() from #TempTRN_PalletLable_Verify
   --values    
   -- (    
   -- @Invoice_No,    
   -- @InvoiceQty,    
   -- @PalletSerialNo,    
   -- @PalletBatchCode,    
   -- @PalletBarcode,    
   -- @InvoiceDate,    
   -- @MachineId,    
   -- @created_By,    
   -- getdate()    
   -- )    
    
   if( @@IDENTITY >0)    
   begin   
  select @palletid=@@IDENTITY
   insert into TRN_InvoiceDetails(   TRN_PalletSerialNo_ID,	InvoiceNo,	PalletSerial_No	,BoxSerialNo,	TRN_BoxSerialNo_ID	,BoxBatchCode	,Pallet_Qty,	Machine_ID	,Created_By	,Created_On)
			select @palletid,
			Invoice_No,
			@PalletSerialNo,
			TRN_PalletLable_Verify.BoxSerialNo,
			TRN_BoxSerialNo_ID,
			TRN_PalletLable_Verify.BoxBatchCode,
			@InvoiceQty,
			1,
			TRN_PalletLable_Verify.Created_By,
			GETDATE()
			 from TRN_PalletLable_Verify 
			 inner join TRN_BoxBarcodeDetails on TRN_PalletLable_Verify.BoxBatchCode=TRN_BoxBarcodeDetails.BoxBatchCode and TRN_PalletLable_Verify.BoxSerialNo=TRN_BoxBarcodeDetails.BoxSerialNo
			 where Code=@UniqueID and PartConfig_Id=@PartConfigID
   
    
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
 @CustPartNo AS CustPartNo,
 @InvoiceNo as InvoiceNo ,
 @InvoiceQty as  InvoiceQty,
 @InvoiceDate as InvoiceDate
    from TRN_PalletSerialNo     
    where TRN_PalletSerialNo_id=@palletid--@@IDENTITY    
    --select 1 as result,@@IDENTITY as TRN_PalletSerialNo_id;    
    
   end    
   else    
   begin    
    select 0 as result,0 as TRN_PalletSerialNo_id, '' as PalletSrNo,'' as Created_On , '' as CustAddress, '' as partdesc;    
   end    
       
        
      
  delete from TRN_PalletLable_Verify where PartConfig_Id = @PartConfigID and Code = @UniqueID    
           
    
    
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
