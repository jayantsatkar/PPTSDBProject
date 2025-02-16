
/*
==================================================================================      
      
Application                   : MES      
   
Object Name                   :[dbo].[usp_AddFileImportLog]   
   
Author                        :    
   
Created on                    :   
   
Database(s)                   : FM_JEMES      
   
Description                   : 
   
Modified_On                   : Jayant Satkar    

Ramark                        : No Changes needed

==================================================================================    
*/   
CREATE PROC [dbo].[usp_AddFileImportLog]  
  
@Type VARCHAR(50),  
@FileName VARCHAR(50),  
@FilePath VARCHAR(50),  
@CreatedBy int

  
AS  
BEGIN  

INSERT INTO [dbo].[FileImportLogs] (Type,FileName,FilePath,CreatedBy,CreatedOn)  VALUES( @Type, @FileName, @FilePath, @CreatedBy,getdate()) 

END
