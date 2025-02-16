-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertPalletLable_Verify]
@Invoice_No	varchar(25),
@PartConfig_Id	bigint,
@InvoiceQty	bigint,
@InvoiceDate	varchar(30),
@Machine_ID	bigint,
@Created_By	bigint,

@BoxBatchCode	varchar(25),
@BoxSerialNo	nvarchar(10),
@Code nvarchar(50)	
AS
BEGIN
	BEGIN TRY
		Begin transaction
INSERT INTO [dbo].[TRN_PalletLable_Verify]
           ([Invoice_No]
           ,[PartConfig_Id]
           ,[InvoiceQty]
           ,[InvoiceDate]
           ,[Machine_ID]
           ,[Created_By]      
           ,[BoxBatchCode]
           ,[BoxSerialNo]
		   ,[Code])
     VALUES
           (@Invoice_No
           ,@PartConfig_Id
           ,@InvoiceQty
           ,@InvoiceDate
           ,@Machine_ID
           ,@Created_By       
           ,@BoxBatchCode
           ,@BoxSerialNo
		   ,@Code)

		   select 1;
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

