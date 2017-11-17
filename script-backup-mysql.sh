#!/bin/bash
###############################################
# Daily Backup MySQL
# Author Wilton Guilherme - TBF HOST
# Year 2017
###############################################

#VARIAVEIS
DATAHORA=`date +%Y%m%d`
MYSQLDUMP=/usr/bin/mysqldump
MYSQLDIR='/backup/banco-dados/'
TAR=/bin/tar
RM=/bin/rm
LOG='/backup/logs'
SENDEMAIL='sh /srv/scripts/send-mail-backup.sh'
DATABASE1='banco01'
DATABASE2=''
IPREMOTE=''
DBSERVER='localhost'
PASSWORD='SenhaMySQL'
ROOT='UserMySQL'


#Limpando Unidade de Backup
$RM -rf $MYSQLDIR/*

#Realizando backup $DATABASE1

$MYSQLDUMP -h$DBSERVER -u$ROOT --password=$PASSWORD  $DATABASE1 > $MYSQLDIR/$DATABASE1.bkp_$DATAHORA.sql

#Entrando no diretorio de backup

cd $MYSQLDIR

##Compactando o backup
$TAR czvf $DATABASE1.bkp_$DATAHORA.tar.gz $DATABASE1.bkp_$DATAHORA.sql

#Copiando Arquivos

s3cmd put $DATABASE1.bkp_$DATAHORA.tar.gz s3://caminho/s3/remoto

#Enviando MSG Backup

$SENDEMAIL
