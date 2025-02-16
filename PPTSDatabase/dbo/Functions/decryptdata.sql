-- ====================================================================================
-- Application 		: AMW
-- Object Name		:  decryptdata 
-- Author			: pramod Desai
-- Created			: 22/03/2012
-- Database(s)		: AMW
-- Description 		: For decryptdata
-- ====================================================================================
CREATE FUNCTION [dbo].[decryptdata] (@firstname VARCHAR(50), @key INT)
RETURNS VARCHAR(60)
AS
BEGIN
	DECLARE @firstname1 INT
	DECLARE @key2 VARCHAR(10)
	DECLARE @encryptdata VARCHAR(60)
	DECLARE @len INT
	SELECT @encryptdata = ''
	SELECT @len=LEN(@firstname)
	WHILE @len>0
	BEGIN
	SELECT @firstname1 = ASCII(SUBSTRING(@firstname,@len,1))
	SELECT @key2=@firstname1-@key
	SELECT @encryptdata = @encryptdata+CHAR(@key2)
	SELECT @len = @len-1
END
RETURN(@encryptdata)
END;

