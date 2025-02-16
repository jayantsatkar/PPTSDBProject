create procedure [dbo].[usp_InsertUpdateBiometricData]
@userId as INT,
@CreatedBy as INT,
@fingerprint varBinary(Max)
as 
Begin
		IF NOT EXISTS(SELECT 1 FROM 	mst_BioMetric WHERE [User_ID]=@userId)
			 BEGIN
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
		@CreatedBy
		)
		END

		ELSE 
		BEGIN 

		   UPDATE  mst_BioMetric SET FingerPrint1=@fingerprint, Modified_On=GETDATE(), Modified_By=@CreatedBy WHERE [User_ID]=@userId

		END 
		

	
end
