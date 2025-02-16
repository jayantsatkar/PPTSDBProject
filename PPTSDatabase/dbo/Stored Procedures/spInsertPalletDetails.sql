-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spInsertPalletDetails 
-- Author			: Namdeo
-- Created			: 17/11/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spInsertPalletDetails]
@TRN_PalletSerialNo_ID bigint,
@BoxBatchCode varchar(20),
@BoxSerialNo varchar(10),
@MachineId bigint,
@created_By bigint
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		Begin transaction

			declare @TRN_BoxSerialNo_ID bigint,
					@PalletSerialNo varchar(10),
					@ActualQty bigint,
					@InvoiceNo varchar(25);

					set @ActualQty=0;

		--get box details
		select 
			@TRN_BoxSerialNo_ID=TRN_BoxSerialNo_ID
		from 
			TRN_BoxSerialNo 
		where 
			BoxSerial_No=@BoxSerialNo
			and BoxBatchCode=@BoxBatchCode;
		
		if(@TRN_BoxSerialNo_ID>0)
		begin
		
		 --Get pallet serial no
			select 
				@PalletSerialNo=PalletSrNo,
				@InvoiceNo=Invoice_No
			from
				TRN_PalletSerialNo
			where 
				TRN_PalletSerialNo_ID=@TRN_PalletSerialNo_ID;
				

				-- save data into 
				insert into 
					TRN_InvoiceDetails
					(
					TRN_PalletSerialNo_ID,
					 InvoiceNo
					,PalletSerial_No
					,BoxSerialNo
					,TRN_BoxSerialNo_ID
					,BoxBatchCode
					,Pallet_Qty
					,Machine_ID
					,Created_By
					,Created_On
					)
					values
					(
						@TRN_PalletSerialNo_ID,
						@InvoiceNo,
						@PalletSerialNo,
						@BoxSerialNo,
						@TRN_BoxSerialNo_ID,
						@BoxBatchCode,
						@ActualQty,
						@MachineId,
						@created_By,
						getdate()
					);
			
			

				if(@@Identity>0)
				begin
					select 1 as result;
				end
				else
				begin
					select 0 as result;
				end
			
		

		commit;
		end
		else
		begin
			select 0 as result;
		end
		

	
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

