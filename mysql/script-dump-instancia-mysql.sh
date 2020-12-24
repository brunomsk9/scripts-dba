#!/bin/bash

# Add your backup dir location, password, mysql location and mysqldump location
DATE=$(date +%d-%m-%Y)
BACKUP_DIR="caminho/parasalvar"
MYSQL_USER="usuario"
MYSQL_PASSWORD="digiteaquiasenha"
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump

# To create a new directory into backup directory location
mkdir -p $BACKUP_DIR/$DATE

# get a list of databases
databases=`$MYSQL -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema)"`

# dump each database in separate name
for db in $databases; do
echo $db
$MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases --single-transaction $db | gzip > "$BACKUP_DIR/$DATE/$db.sql.gz"
done

# Delete files older than 3 days
find $BACKUP_DIR/* -mtime +3 -exec rm -Rf {} \;


