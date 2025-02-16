CREATE FUNCTION [dbo].[DecryptDMCBatchCode] (@BatchCode VARCHAR(4))
RETURNS VARCHAR(50)
AS
BEGIN
--	DECLARE @BatchCode VARCHAR(4)
--	SET @BatchCode='EH7C'

	DECLARE @ShiftCode VARCHAR(1),@DayCode VARCHAR(1), @MonthCode VARCHAR(1), @YearCode VARCHAR(1), @ShiftCodeDecrypted VARCHAR(2),@DayCodeDecrypted VARCHAR(2), @MonthCodeDecrypted VARCHAR(2), @YearCodeDecrypted VARCHAR(2),
	@DecryptedData VARCHAR(50)

	SELECT @DayCode= SUBSTRING(@BatchCode,1,1), @MonthCode=SUBSTRING(@BatchCode,2,1),@YearCode =SUBSTRING(@BatchCode,3,1), @ShiftCode = SUBSTRING(@BatchCode,4,1)

	--SELECT @ShiftCode AS ShiftCode ,@DayCode AS DayCode, @MonthCode AS MonthCode, @YearCode AS YearCode
	
	----DAY CODE LOGIN
	---CHECK IS IT 3RD SHIFT THEN MINUS 1 DAY AS PER BUSINESS LOGIC
	--SET @ShiftCode=''
	 ---SELECT * FROM ShiftCode WHERE ShiftCCodes=@ShiftCode	
	IF EXISTS (SELECT 1 FROM ShiftCode WHERE ShiftCCodes=@ShiftCode)
	BEGIN
	
		SELECT @ShiftCodeDecrypted= ShiftCodes FROM ShiftCodeMappings WHERE Id=3 
		SELECT @DayCodeDecrypted= DayCode FROM DayCode WHERE ShiftCode3=@DayCode
	END

	ELSE IF EXISTS (SELECT 1 FROM ShiftCode WHERE ShiftBCodes=@ShiftCode)
	BEGIN
		SELECT @ShiftCodeDecrypted= ShiftCodes FROM ShiftCodeMappings WHERE Id=2
		SELECT @DayCodeDecrypted= DayCode FROM DayCode WHERE [ShiftCode1-2]=@DayCode
	END

	ELSE IF EXISTS (SELECT 1 FROM ShiftCode WHERE ShiftACodes=@ShiftCode)
	BEGIN
		SELECT @ShiftCodeDecrypted= ShiftCodes FROM ShiftCodeMappings WHERE Id=1
		SELECT @DayCodeDecrypted= DayCode FROM DayCode WHERE [ShiftCode1-2]=@DayCode
	END
	--SELECT @DayCodeDecrypted AS DayCodeDecrypted,@ShiftCodeDecrypted AS ShiftCodeDecrypted
	
	------MONTH CODE LOGIC
	SELECT @MonthCodeDecrypted= MonthId FROM MonthCode WHERE MonthCode=@MonthCode 

	------YEAR CODE LOGIC

	SELECT @YearCodeDecrypted= YearString FROM YearCode WHERE YearCode=@YearCode

	--SELECT @YearCodeDecrypted AS YearCodeDecrypted
	--SELECT @DayCodeDecrypted AS DayCodeDecrypted, @MonthCodeDecrypted AS MonthCodeDecrypted, @YearCodeDecrypted AS YearCodeDecrypted,@ShiftCodeDecrypted AS ShiftCodeDecrypted

	SET @DecryptedData= @DayCodeDecrypted+@MonthCodeDecrypted+@YearCodeDecrypted+':'+@ShiftCodeDecrypted
	--040817:03
RETURN @DecryptedData
END
