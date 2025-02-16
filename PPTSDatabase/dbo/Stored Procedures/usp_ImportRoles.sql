CREATE PROCEDURE [dbo].[usp_ImportRoles]
@JsonFileData nVarchar(MAX),
 @userId INT
AS
BEGIN
IF (@JsonFileData='')
BEGIN
SELECT '' AS RoleName,'' AS RoleDesc,' No data avaliable in file' AS ErrorMessage 
END
ELSE
BEGIN
--Checking Column name
DECLARE @tblRoles Table ( RoleName nvarchar(MAX),RoleDesc nvarchar(MAX),IsValid BIT,ErrorMEssage VARCHAR(max))

--Adding File Column name
DECLARE @tblJsonColumn TABLE  ( JsonKey NVARCHAR(MAX)) 

--Add Actula Column name for compare with file column 
DECLARE @tblMSTRoleColumn TABLE  ( TableColumn NVARCHAR(MAX))

DECLARE @counts INT;


DECLARE @columnName varchar(max) = 'RoleName,RoleDesc'
INSERT INTO @tblMSTRoleColumn(TableColumn)
SELECT VALUE FROM string_split(@columnName,',')

--Added Json Column name
INSERT INTO @tblJsonColumn (JsonKey)
SELECT DISTINCT K.[key]
FROM OPENJSON(@JsonFileData) AS j
CROSS APPLY (
    SELECT *
    FROM OPENJSON(j.value)
) AS k --,
--(select value from string_split(@columnName,',')) AS l

SELECT @counts =COUNT(1)  FROM 
@tblMSTRoleColumn t WHERE t.TableColumn NOT IN (SELECT JsonKey FROM @tblJsonColumn)


 

IF(@counts >0)
	BEGIN
	SELECT '' AS RoleName,'' AS RoleDesc,'Column name missed matched, Please upload proper role format file' AS ErrorMessage 
	END
ELSE
		BEGIN

		INSERT INTO @tblRoles (RoleName  ,RoleDesc ,IsValid  ,ErrorMessage )SELECT REPLACE(RoleName,' ',''),RoleDesc,1,''   FROM OPENJSON(@JsonFileData)WITH(RoleName VARCHAR(MAX),RoleDesc VARCHAR(MAX));
		--SELECT * FROM @tblRoles
		--Required Validation
		UPDATE @tblRoles SET ErrorMessage=' Role Name is Required',IsValid=0 where RoleName=''
		UPDATE @tblRoles SET ErrorMessage=ErrorMessage+','+'Role Description is Required',IsValid=0 where RoleDesc=''

-- Validate duplicate rolename value in excel

		DECLARE @DuplicateValues TABLE (RoleName nVarchar(MAx))
		INSERT INTO @DuplicateValues(RoleName)
		SELECT RoleName FROM (
		SELECT  rolename,count(1) AS Count  FROM @tblRoles WHERE RoleName<>'' GROUP BY RoleName
		)t where t.Count>1--having  count(RoleName)>1
		
		UPDATE r 
		SET r.ErrorMEssage= ErrorMessage+','+'Role Name is duplicate in the sheet',r.IsValid=0  
		FROM @tblRoles r 
		JOIN @DuplicateValues t on t.RoleName=r.RoleName
	
		--Duplicate Validation
		--SELECT tr.* FROM MST_Role r 
		--JOIN @tblRoles tr on tr.RoleName=r.RoleName AND  tr.RoleName!=''

		UPDATE tr SET tr.ErrorMessage= ErrorMessage+','+'Role Name is already exist',tr.IsValid=0
		FROM MST_Role r 
		JOIN @tblRoles tr on tr.RoleName=r.Role_Name AND  tr.RoleName!=''AND R.IsActive=1


		--Length Validtion
		--SELECT * FROM @tblRoles where LEN(RoleName)>200
		UPDATE @tblRoles SET ErrorMessage=ErrorMessage+','+'Role Name charachter max length is 200',IsValid=0 where LEN(RoleName)>200
		UPDATE @tblRoles SET ErrorMessage=ErrorMessage+','+'Role Desc charachter max length is 200',IsValid=0 where LEN(RoleDesc)>200
		--SELECT * FROM @tblRoles


		INSERT INTO MST_Role (Role_Name,Role_Desc,IsActive,Created_By,Created_On)
		SELECT RoleName,RoleDesc,1,@userId,GETDATE() FROM @tblRoles Where IsValid=1


		UPDATE @tblRoles SET ErrorMessage=' Saved Successfully' WHERE IsValid=1

		SELECT RoleName,RoleDesc, SUBSTRING(ErrorMessage,2,LEN(ErrorMessage)) as ErrorMessage     FROM @tblRoles


		END

	END
END


