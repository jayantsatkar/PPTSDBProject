-- ====================================================================================
-- Application 		: PPTS
-- Object Name		: spGetFormsandModuleforUser 
-- Author			: Namdeo
-- Created			: 28/10/2015
-- Modified By		: Namdeo Shinde
-- Modified On		: 
-- Database(s)		: BOSCH_PPTS
-- ====================================================================================

CREATE PROCEDURE [dbo].[spGetFormsandModuleforUser]
	@pUser_Id bigint
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY
		
		-- to get models and its forms
			select * from (
				select  0 as Sub_Module_ID,'0' as Sub_Module_Name,'0' as Frm_Name
							,'0' as  Frm_URL , 0 as Frm_ID,0 as Flag_Visible, 0 as Frm_Order ,
							 Module_Name, Module_ID,Module_Order  
				from MST_Module  
				where Module_ID in(
				select distinct Module_ID from MST_Form, REL_UserForm 
				where REL_UserForm.User_Id=@pUser_Id and MST_Form.Frm_Id=REL_UserForm.Frm_Id  )
				and MST_Module.IsActive=1
				union 
				select  
						isnull(Sub_Module_ID,0) as Sub_Module_ID,
								isnull((select Sub_Module_Name from MST_SubModule where Sub_Module_ID = MST_Form.Sub_Module_ID),'XXX') as Sub_Module_Name,
								Frm_Name, 
										Frm_URL,
										MST_Form.Frm_Id,
										Flag_Visible,
										Frm_Order,
										MST_Module.Module_Name,
										MST_Module.Module_ID,
										MST_Module.Module_Order
						from MST_Form inner join REL_UserForm  on REL_UserForm.Frm_Id=MST_Form.Frm_Id
							inner join MST_Module on MST_Module.Module_ID=MST_Form.Module_ID
						where  REL_UserForm.User_Id =@pUser_Id
							and Flag_Visible=1
							--and REL_UserForm.frm_id not in (13,14,15,16)
							and MST_Module.IsActive=1) as temp 
						order by  temp.Module_Order, temp.Frm_Order asc




	
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

