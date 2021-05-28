#!/bin/bash

# Adicione a localização do diretório de backup, senha, localização do mysql e localização do mysqldump
DATE=$(date +%d-%m-%Y)
BACKUP_DIR="caminho/parasalvar"
MYSQL_USER="usuario"
MYSQL_PASSWORD="senha"
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump

# Criar um novo diretório 
mkdir -p $BACKUP_DIR/$DATE

# get a list of databases
databases=`$MYSQL -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema)"`

# Dump individual de cada banco de dados
for db in $databases; do
echo $db
$MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases --single-transaction $db | gzip > "$BACKUP_DIR/$DATE/$db.sql.gz"
done

# Exclua arquivos com mais de 3 dias
find $BACKUP_DIR/* -mtime +3 -exec rm -Rf {} \;


