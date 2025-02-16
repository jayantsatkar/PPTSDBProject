-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spInsertPartConfig 
-- Author			: Namdeo
-- Created			: 23/12/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spInsertScanbarcode]
@PartBarcode varchar(60),
@PartSerialNo varchar(10),
@created_By bigint
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		Begin transaction


		
			insert into 
				TRN_ScanPartBarcode
				(
					   [PartBarcode]
					  ,[PartSerialNo]
					  ,[Created_By]
					  ,[Created_On]
					)
					values
					(
						@PartBarcode ,
						@PartSerialNo ,
						@created_By ,
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

