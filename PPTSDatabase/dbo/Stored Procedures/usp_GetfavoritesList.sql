 --==================================================================================                              
                              
-- Application      : MES                              
                              
-- Object Name                   :[dbo].[usp_GetfavoritesList]                          
                              
-- Author                        :Vidhi More                              
                              
-- Created on                    :MARCH 30, 23                              
                              
-- Database(s)                   :FM_JEMES                              
                              
-- Description                   :This sp will fetch the flag value based on form id                
                              
-- Modified_On                   :                           
                              
-- Modified By                   :                   
          
          
CREATE PROC [dbo].[usp_GetfavoritesList]             
        
@FormId INT  ,  
@UserId INT  
AS          
BEGIN          
 SELECT IsFavorites FROM TRN_Favorites WHERE FormId= @FormId  AND UserId = @UserId  
          
END 