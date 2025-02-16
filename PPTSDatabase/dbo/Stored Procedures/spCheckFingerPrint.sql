CREATE procedure  [dbo].[spCheckFingerPrint]
@Userid as bigint
as
Begin
	
	
	
	select 
		FingerPrint1
	from
		MST_BioMetric
	where
		user_id=@Userid
		and IsActive=1
		

End





