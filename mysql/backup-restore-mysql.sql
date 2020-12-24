-- Backup Completo -- 
mysqldump -u usuario -p nomedobanco > nomebackup.sql


-- Backup Eliminando uma ou mais Tabelas -- 
mysqldump  -v -u usuario -p db_nome_base --ignore-table=db_nome_base.tabela > backup_sem_tabelax.sql


--  Backup Apenas da Estrutura --
mysqldump -v -u usuario -p -f --no-data --complete-insert --quote-names db_nome_base > backup_estrutura.sql


-- Backup Apenas da Tabela -- 
mysqldump -u usuario -p -h localhost db_nome_base.tabelax > backup_tabelax.sql


-- Restaurar Base de Dados --
mysql -u usuario -p -h localhost db_nome_base_destino < db_nome_base_origem.sql


