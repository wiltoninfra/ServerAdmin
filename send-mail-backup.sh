#!/bin/sh
###############################################
# Send Mail Administrator Network
# Author Wilton Guilherme TBF HOST
# Year 2017
#
# Ncessário a Instalação do Postfix, Mailutils.
#
###############################################

#Variaveis de ambiente
FROM="wiltoninfra@gmail.com"
TO="wiltoninfra@gmail.com"

#Titulo do Email
SUBJECT="Backup SERVER XYZ Concluido $(date "+dia %d de %b de %Y as %r")"

#Montando Corpo do Email

MSG=$(tree -l -h -C -D --charset x /home/tbfhost/jobs/bkp-banco)
MSG2=$(du -hs /home/tbfhost/jobs/bkp-banco)

cat <<EOF | /usr/sbin/sendmail -t
From: $FROM
To: $TO
Subject: $SUBJECT

Olá , enviando as tarefas de backups executadas.

Resultado no Backup Local:
$MSG

Tamanho Total do Backup:
$MSG2
________________________________________________________
Script BAKCUP
#
