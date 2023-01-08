#!/bin/bash

#####################################################################
#  TITRE: Mysql  Backups
#
#  VERSION: 0.1
#  CREATION:  08/01/2023
#
#  DESCRIPTION: Backup for mysql 
#####################################################################

set -euo pipefail

while getopts d: flag
do
	case "${flag}" in
		d) DATABASE=${OPTARG};;
		*) 
		echo "Usage: $0 <-d database >" >&2
                exit 1 ;;
	esac
done

### Variables #######################################################

DUMP_FILE=$(date +"%Y-%m-%d")_dump_mariadb_$(hostname).sql
DATE=$(date +"%Y-%m-%d.%H_%M_%S")
BACKUP_PATH=/data/backups/$(hostname)

### Functions #######################################################

backup(){

  echo $(date +"%Y-%m-%d.%H_%M_%S")" - Start - Backup $1" | tee -a /var/log/mysql/backups.log
  mkdir -p ${BACKUP_PATH}
  touch ${BACKUP_PATH}/mysql_backup_$1_start.txt
  mysqldump --opt $1 > /${BACKUP_PATH}/${DUMP_FILE}.dmp 2>&1 | tee -a /var/log/mysql/backups.log
  sleep 60s
  touch ${BACKUP_PATH}/mysql_backup_$1_end.txt
  echo $(date +"%Y-%m-%d.%H_%M_%S")" - End - Backup $1" | tee -a /var/log/mysql/backups.log

}

#####################################################################

backup $DATABASE

