-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spInsertPartConfig 
-- Author			: Namdeo
-- Created			: 23/12/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spInsertPartConfig]
@BoschPartNo varchar(18),
@CustIndex varchar(3),
@MST_Customer_Id bigint,
@partdesc varchar(100),
@PartSerialNo varchar(10),
@CustPartNo varchar(18),
@NoOfParts bigint,
@PackedIn varchar(30),
@LineId varchar(10),
@LineNo varchar(30),
@created_By bigint
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		Begin transaction


		
			insert into 
				MST_PartConfiguration
				(
					   [BoschPart_No]
					  ,[Customer_Index]
					  ,[MST_Customer_ID]
					  ,[BoschPart_Desc]
					  ,[CustPart_No]
					  ,[NoOfPartQy_Box]
					  ,[Packed_In]
					  ,[Line_Id]
					  ,[Line_No]
					  ,[Created_By]
					  ,[Created_On]
					)
					values
					(
						@BoschPartNo ,
						@CustIndex ,
						@MST_Customer_Id ,
						@partdesc ,
						@CustPartNo ,
						@NoOfParts ,
						@PackedIn ,
						@LineId ,
						@LineNo ,
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

