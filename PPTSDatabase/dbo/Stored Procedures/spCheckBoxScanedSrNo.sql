-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spCheckPartNoScaned 
-- Author			: Namdeo
-- Created			: 20/11/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spCheckBoxScanedSrNo]
@BoxBatchNo Varchar(20),
@BoxSerialNo varchar(10),
@PartConfigID bigint
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY

	declare @Count bigint,
			@countvalid bigint;
		
		-- to get models and its forms
		select 
			@countvalid=count(*)
		from
			vw_TRN_BoxSerialNo
		where
			MST_PartConfiguration_ID=@PartConfigID
			and BoxSerial_No=@BoxSerialNo
			and BoxBatchCode=@BoxBatchNo;

		if(@countvalid>0)
		begin	
			set @Count=0;
												select 
				@Count=count(*) 
			from 
				TRN_InvoiceDetails,TRN_BoxSerialNo 
			where 
				TRN_BoxSerialNo.TRN_BoxSerialNo_ID=TRN_InvoiceDetails.TRN_BoxSerialNo_ID
				and TRN_BoxSerialNo.MST_PartConfiguration_ID =@PartConfigID 
				and TRN_InvoiceDetails.BoxBatchCode=@BoxBatchNo
				and TRN_InvoiceDetails.BoxSerialNo =@BoxSerialNo

			if(@Count=0)
			begin
				select 1 as result
			end
			else
			begin
				select 0 as result
			end
		end
		else
		begin
			select 2 as result
		end
	
	END TRY
	BEGIN CATCH
	SET NOCOUNT ON;
		INSERT INTO ErrorLog(ERROR_PROCEDURE, ERROR_LINE, ERROR_NUMBER, ERROR_MESSAGE, ERROR_TIME)
		SELECT ERROR_PROCEDURE(),
			  ERROR_LINE(),
			  ERROR_NUMBER(),
			  ERROR_MESSAGE(),
			  CURRENT_TIMESTAMP;
	END CATCH
END

