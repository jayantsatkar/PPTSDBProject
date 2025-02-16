CREATE procedure  [dbo].[spCheckFingerPrintCount]
@Userid as bigint
as
Begin
	
	declare @fIngurePrintCount as Bigint
	
	select 
		isnull(count(*),0) as result
	from
		MST_BioMetric
	where
		user_id=@Userid
		and IsActive=1

End





