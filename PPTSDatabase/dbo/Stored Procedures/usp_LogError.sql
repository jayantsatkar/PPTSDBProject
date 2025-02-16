CREATE PROCEDURE [dbo].[usp_LogError] (
  @machineName nvarchar(200),
  @logged datetime,
  @level varchar(5),
  @message nvarchar(max),
  @logger nvarchar(300),
  @properties nvarchar(max),
  @callsite nvarchar(300),
  @exception nvarchar(max)
) AS
BEGIN

IF CHARINDEX('`',@message) > 0
BEGIN


INSERT INTO [dbo].[ErrorLogs] (
[ID],
    [MachineName],
    [Logged],
    [Level],
    [Message],
    [Logger],
    [Properties],
    [Callsite],
    [Exception]
  ) VALUES (
   SUBSTRING (@message,1,36),
    @machineName,
    GETDATE(),
    @level,
   SUBSTRING (@message,38, LEN(@message)-37),
    @logger,
    @properties,
    @callsite,
    @exception
  );

END

ELSE 

BEGIN


  INSERT INTO [dbo].[ErrorLogs] (
    [MachineName],
    [Logged],
    [Level],
    [Message],
    [Logger],
    [Properties],
    [Callsite],
    [Exception]
  ) VALUES (
    @machineName,
   GETDATE(),
    @level,
    @message,
    @logger,
    @properties,
    @callsite,
    @exception
  );

  END
END