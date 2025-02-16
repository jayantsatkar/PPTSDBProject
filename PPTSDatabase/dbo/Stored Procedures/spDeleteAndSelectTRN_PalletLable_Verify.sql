-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteAndSelectTRN_PalletLable_Verify]
	@PartConfigID nvarchar(50),
	@UniqueID nvarchar(50)
AS
BEGIN
		SET NOCOUNT ON;
	BEGIN TRY
		Begin transaction 

		create table #TempTRN_PalletLable_Verify
		(
			Invoice_No	varchar(25),
			PartConfig_Id	nchar(10),
			InvoiceQty	bigint,
			InvoiceDate	varchar(30),
			Machine_ID	bigint,
			Created_By	bigint,
			BoxBatchCode	varchar(25),
			BoxSerialNo	nvarchar(10)
			
	
			
		)
		insert into #TempTRN_PalletLable_Verify
		select Invoice_No , PartConfig_Id , InvoiceQty ,  InvoiceDate , Machine_ID,  created_By, BoxBatchCode , BoxSerialNo  from [dbo].[TRN_PalletLable_Verify] where PartConfig_Id = @PartConfigID and Code=@UniqueID
		
		
		delete from TRN_BoxLable_Verify where PartConfig_Id = @PartConfigID and Code = @UniqueID

		select Invoice_No , PartConfig_Id , InvoiceQty , InvoiceDate, created_By , Machine_ID,  Created_By ,  BoxBatchCode , BoxSerialNo from #TempTRN_PalletLable_Verify
		   


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

