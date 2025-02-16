-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: [spCheckPartconfiguration] 
-- Author			: Namdeo
-- Created			: 23/12/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spCheckPartconfiguration]
@CustName varchar(100),
@CustIndex varchar(3),
@CustCode varchar(30),
@PartNo varchar(18)
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY

	declare @Count bigint,
			@countvalid bigint,
			@mst_Customer_Id int;
		
		-- to get models and its forms


		select 
			@mst_Customer_Id=MST_Customer_ID 
		from 
			MST_Customer 
		where 
			Customer_Name=@CustName 
			and Customer_Index=@CustIndex 
			and Customer_Code=@CustCode

		if(@mst_Customer_Id>0)
		begin
			select 
				@countvalid=count(*)
			from
				MST_PartConfiguration
			where
				MST_Customer_ID=@mst_Customer_Id
				and BoschPart_No=@PartNo
			
			if(@countvalid>0)
			begin
				select 0 as result, 1 as customer;
			end
			else
			begin
				select @mst_Customer_Id as result,1 as customer;
			end
		end
		else
		begin
			select 0 as result,0 as customer;

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

