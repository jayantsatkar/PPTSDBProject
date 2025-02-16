-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spCheckPartNoScaned 
-- Author			: Namdeo
-- Created			: 02/11/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spCheckPartNoScaned]
@PartNo varchar(18),
@BatchNo Varchar(20),
@SerialNo varchar(10),
@PartConfigID bigint
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY

	declare @Count bigint
		
		-- to get models and its forms
			
		set @Count=0;
			select 
				@Count=count(*) 
			from 
				vw_TRN_BoxBarcodeDetails 
			where 
				MST_PartConfiguration_ID=@PartConfigID 
				and PartBatchCode=@BatchNo
				and PartSerialNo=@SerialNo

		if(@Count=0)
		begin
			select 1 as result
		end
		else
		begin
			select 0 as result
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

