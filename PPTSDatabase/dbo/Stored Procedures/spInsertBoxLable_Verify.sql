-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertBoxLable_Verify]
	@PartConfig_Id bigint,
@PartActualQty bigint,
@MachineId bigint,
@created_By bigint,
@BoschPartNo nvarchar(21),	
@PartBatchCode nvarchar(20),
@PartSerialNo  varchar(50),
@Code nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		Begin transaction

		INSERT INTO [dbo].[TRN_BoxLable_Verify]
           ([PartConfig_Id]
           ,[PartActualQty]
           ,[MachineId]
           ,[created_By]
           ,[BoschPartNo]
           ,[PartBatchCode]
           ,[PartSerialNo]
           ,[Code])
     VALUES
           (@PartConfig_Id ,
		   @PartActualQty,
		   @MachineId,
		   @created_By,
		   @BoschPartNo,
		   @PartBatchCode,
		   @PartSerialNo,
		   @Code)

		   select 1 ;


commit

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

			  select 0;
	END CATCH
END

