DECLARE @name VARCHAR(150) -- Nome do Database  
DECLARE @path VARCHAR(256) -- Caminho do arquivo de backup
DECLARE @fileName VARCHAR(256) -- Arquivo do backup  
DECLARE @dia VARCHAR(10) -- dia do backup
SET @dia = CONVERT (varchar,GETDATE(), 112) --formata o dia no padrao iso (yymmdd)

-- Define caminho de destino do backup
SET @path = '\\servidorderede\Share\Diretorio\'  

-- Cria um cursor para selecionar todas as databases,  
--  excluindo model, msdb e tempdb
DECLARE db_cursor CURSOR FOR  
   SELECT name 
     FROM master.dbo.sysdatabases 
    WHERE name NOT IN ('model','msdb','tempdb')

-- Abre o cursor e faz a primeira leitura 
OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

-- Loop de leitura das databases selecionadas
WHILE @@FETCH_STATUS = 0   
BEGIN    
   SET @fileName = LTRIM( @path + @name + @dia + '.bak')  --remove os espacos 
   -- Executa o backup para o database
   BACKUP DATABASE @name TO DISK = @fileName WITH FORMAT;  

   FETCH NEXT FROM db_cursor INTO @name   
END   

-- Libera recursos alocados pelo cursor
CLOSE db_cursor   
DEALLOCATE db_cursor 