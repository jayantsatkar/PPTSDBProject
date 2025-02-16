CREATE procedure [dbo].[spInsertBiometricdata]
@userId as bigint,
@Created_By as Bigint,
@fingerprint varBinary(Max)
as 
Begin
	declare @FingerPrint1 as varbinary(Max),
			@FingerPrint2 as varbinary(Max),
			@FingerPrint3 as varbinary(Max)

	INSERT INTO 
		mst_BioMetric 
		(
		User_ID, 
		FingerPrint1,
		IsActive,
		Created_On,
		Created_By
		) 
	VALUES 
		(@userId, 
		@fingerprint,
		1,
		getdate(),
		@Created_By
		)
		

	
end
