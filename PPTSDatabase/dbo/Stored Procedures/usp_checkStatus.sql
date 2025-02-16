

-- usp_checkStatus 'MST_Slot' ,284           
                
CREATE PROCEDURE [dbo].[usp_CheckStatus]                 
                 
@TableName VARCHAR(100) ,                
@inputID INT                
AS                
BEGIN                
DECLARE @Exist BIT                 
DECLARE @sql NVARCHAR(MAX)                
DECLARE @pktable_name NVARCHAR(80)                
DECLARE @Count INT                
DECLARE @Start INT =1;                
DECLARE @End INT                
DECLARE @tempColumnName VARCHAR(80)                
DECLARE @tempTableName VARCHAR(max)                
DECLARE @rowCount TABLE (CountOfRow INT);                
DECLARE @checkCount INT;                
DECLARE @isActiveExsist INT;                
                
                
if(OBJECT_ID('tempdb..#tableData') is NOT NULL )                
DROP table #tableData                
--if(@TableName = 'Mst_Equipment')
--BEGIN
--update MST_Equipment_BobbinsDetails set IsActive = 0 where EquipmentId =  @inputID      -- vishal Changes  
--END
CREATE TABLE #tableData                 
(                
 ID INT Identity (1,1),                
     PKTABLE_QUALIFIER sysname                
 ,PKTABLE_OWNER sysname                
 ,PKTABLE_NAME sysname                
 ,PKCOLUMN_NAME sysname                
 ,FKTABLE_QUALIFIER sysname                
 ,FKTABLE_OWNER sysname                
 ,FKTABLE_NAME sysname                
 ,FKCOLUMN_NAME varchar(32)                
 ,KEY_SEQ smallint                
 ,UPDATE_RULE smallint                
 ,DELETE_RULE smallint                
 ,FK_NAME sysname                
 ,PK_NAME sysname                
 ,DEFERRABILITY smallint                
);            
      
      
CREATE TABLE #ChildTableData                 
(      
   ChildTableName varchar(100)      
)      
      
SET @Exist =0                  
                
SET @sql = 'EXEC sp_fkeys @pktable_name=' + @TableName                
        
INSERT  #tableData                 
EXEC sp_executesql @sql       
SELECT @End= COUNT(1) FROM #tableData                
--select * from #tableData                
--Select @End AS ENDDATA         
      
      
--WHILE(@Start <= @End)                
-- BEGIN       
--      SELECT @tempColumnName= FKCOLUMN_NAME ,@tempTableName =FKTABLE_NAME  FROM #tableData WHERE ID = @Start                
--         insert into #ChildTableData values ( @tempTableName)      
--      SET @Start = @Start +1;         
-- END      
      
--    SET @Start=1;            
WHILE(@Start <= @End)                
 BEGIN                
                
         SELECT @tempColumnName= FKCOLUMN_NAME ,@tempTableName =FKTABLE_NAME  FROM #tableData WHERE ID = @Start                
                
    --   IF EXISTS ( select 1 from #ChildTableData where ChildTableName  IN (    
    -- SELECT ChildTable FROM MST_SkipFKChildReleation where Mastertable = @TableName AND ChildTable=@tempTableName AND  IsActive =1    
    --))    
    
     IF NOT EXISTS (    
     SELECT 1 FROM MST_SkipFKChildReleation where Mastertable = @TableName AND ChildTable=@tempTableName AND  IsActive =1    
    )    
                 
           BEGIN      
             IF EXISTS (                
                SELECT 1                 
                  FROM INFORMATION_SCHEMA.COLUMNS                 
                    WHERE table_name = @tempTableName                
                    AND column_name = 'IsActive')                
                 SET @isActiveExsist =1                
             ELSE                
                 SET @isActiveExsist =0                
                 SET @sql = N'SELECT COUNT(1) ' + N'FROM ' + @tempTableName      
             IF(@isActiveExsist = 1)                
              BEGIN        
         
                 SET @sql = @sql + N' WHERE ' + @tempColumnName + N'= ' + CAST(@inputID AS CHAR(10)) + N'AND IsActive= 1'                
              END                
              ELSE                
              BEGIN                
                SET @sql = @sql + N' WHERE ' + @tempColumnName + N'= ' + CAST(@inputID AS CHAR(10))   
        
               END          
    
           INSERT INTO @rowCount                
              EXEC sp_executesql @sql                 
                         
              SELECT @checkCount = CountOfRow FROM @rowCount                 
             --SELECT @checkCount            
          -- select * from @rowCount as TableValue                
                         
            IF (@checkCount>0)                
            BEGIN                
              SET @Exist=1                
            BREAK;                
            END                
                            
             SET @Start = @Start +1;                
                         
                             
            END               
  ELSE               
     BEGIN              
       SET @Start = @Start +1;                
     END              
  END              
           if(@TableName = 'MST_Checklist' AND EXISTS(select 1 from MST_WorkflowActionForProcess where SelectedId = @inputID AND PageId = 1 AND IsActive =1))   
     BEGIN  
     select @Exist = 1  
     END  
               if(@TableName = 'MST_WorkInstruction' AND EXISTS(select 1 from MST_WorkflowActionForProcess where SelectedId = @inputID AND PageId = 3 And IsActive = 1))   
     BEGIN  
     select @Exist = 1  
     END  
	    if(@TableName = 'MST_SparePart' AND EXISTS(select 1 from REL_SlotContainerTypeStatic RS INNER JOIN MST_Slot MS WITH(NOLOCK) ON MS.id = RS.SlotId
		INNER JOIN MST_Rack MR WITH(NOLOCK) ON MR.id = MS.RackId INNER JOIN MST_Location_WareHouse MLW WITH(NOLOCK) ON MLW.Id = MR.LocationId
		INNER JOIN MST_Zone MZ WITH(NOLOCK) ON MZ.Id = MLW.ZoneId INNER JOIN MST_Supermarket MSM WITH(NOLOCK) ON MSM.Id = MZ.SupermarketId
		where MSM.TypeId = 1 AND RS.PartNo = @inputID ))   
     BEGIN  
     select @Exist = 1  
     END  
	      if(@TableName = 'MST_SparePart' AND EXISTS(select 1 from REL_LinkSparePartToMaintenanceWorkflow where SparePartId = @inputID ))   
     BEGIN  
     select @Exist = 1  
     END  
	 if(@TableName = 'MST_MaintenanceWorkFlow' AND EXISTS(select 1 from TRN_PMOrders where MaintenanceWorkFlowId = @inputID AND StatusId != 3 ))   
     BEGIN  
     select @Exist = 1  
     END  
      if(@TableName = 'Mst_Equipment' AND @Exist = 0)
		BEGIN
		update MST_Equipment_BobbinsDetails set IsActive = 0 where EquipmentId =  @inputID      -- vishal Changes  
		END
	 --ELSE
	 --BEGIN
	 --select @Exist = 0  
	 --END
SELECT @Exist AS Exist                
                
                
END