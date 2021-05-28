DECLARE @SchemaAtual AS VARCHAR(50);
DECLARE @SchemaNovo AS VARCHAR(50);
SET @SchemaAtual = 'sfcokeservice';
SET @SchemaNovo = 'dbo';

SELECT RowNum = ROW_NUMBER() OVER(ORDER BY t.TABLE_NAME),
TableName = 'ALTER SCHEMA [' +@SchemaNovo+ '] TRANSFER [' +@SchemaAtual+ '].[' + TABLE_NAME + ']'
INTO #alterSchema
FROM INFORMATION_SCHEMA.TABLES t

 
DECLARE @Iter INT
DECLARE @MaxIndex INT
DECLARE @ExecMe VARCHAR(MAX)
  
SET @Iter = 1
SET @MaxIndex =
(
    SELECT COUNT(1)
    FROM #alterSchema
)
  
WHILE @Iter <= @MaxIndex
BEGIN
    SET @ExecMe =
    (
        SELECT TableName
        FROM #alterSchema
        WHERE RowNum = @Iter
    )
  
    EXEC (@ExecMe)
    PRINT @ExecMe + ' Executed'
  
    SET @Iter = @Iter + 1
END

DROP TABLE #alterSchema