#!/usr/bin/bash

###############################################################
#  TITRE: Mysql Monitor
#
#  VERSION: 0.1
#  CREATION:  08/01/2023
#
#  DESCRIPTION: Mysql backups metrics generator
#
###############################################################

set -euo pipefail


# Variables ###################################################

METRICS_DIR="/var/lib/node-exporter"
METRICS_FILE="${METRICS_DIR}/mysql-backups-custom.prom"
TOUCH_DIR="/data/backups/$(hostname)/"

# Functions ###################################################

timestamp_file(){
    timestamp_of_file=$(stat -c %Y $1)
    echo ${timestamp_of_file}
}

editMetric () {
    echo "# HELP $1 $2"
    echo "# TYPE $1 $3"
    echo "$1{$4=\"$5\"} $6"
}

#########################################################

rm -f ${METRICS_FILE}

for file in $(ls ${TOUCH_DIR}/mysql_backup_*_start*);do 

  if [ -f "$file" ];then
    database=$(basename $file | awk -F "_" '{print $3}')
    timestamp_file=$(timestamp_file "$file")
    editMetric "mysql_backup_start_timestamp" "Begining of the mysql backup in epoch" "gauge" "database" "${database}"  ${timestamp_file} >> ${METRICS_FILE}
  fi

done


for file in $(ls ${TOUCH_DIR}/mysql_backup_*_end*);do 

  if [ -f "$file" ];then
    database=$(basename $file | awk -F "_" '{print $3}')
    timestamp_file=$(timestamp_file "$file")
    editMetric "mysql_backup_end_timestamp" "End of the mysql backup in epoch" "gauge" "database" "${database}"  ${timestamp_file} >> ${METRICS_FILE}
  fi

done

mariadb_version=$(/usr/sbin/mariadbd --version | awk '{print $3}')
editMetric "mysql_info_version" "Some informations about mariadb" "gauge" "mariadb_version" "${mariadb_version}" 1 >> ${METRICS_FILE}

