#!/usr/bin/bash

###############################################################
#  TITRE: Scylla Backups Monitor
#
#
#  DESCRIPTION: Scylla backups metrics generator
#
###############################################################

set -euo pipefail

# Variables ###################################################

METRICS_DIR="/var/lib/node-exporter"
METRICS_FILE="${METRICS_DIR}/scylla-custom.prom"
TOUCH_DIR="/var/log/scylla/"

# Functions ###################################################

timestamp_file(){
    timestamp_of_file=$(stat -c %Y $1)
    echo ${timestamp_of_file}
}

editMetric () {
    echo "# HELP $1 $2"
    echo "# TYPE $1 $3"
    echo "$1{cluster=\"$4\"} $5"
}

#########################################################

mkdir -p ${METRICS_DIR}
rm -f ${METRICS_FILE}

for file in $(ls ${TOUCH_DIR}/scylla_*_*_start*);do 

  if [ -f "$file" ];then
    cluster=$(basename $file | awk -F "_" '{print $3}')
    action=$(basename $file | awk -F "_" '{print $2}')
    timestamp_file=$(timestamp_file "$file")
    editMetric "scylla_${action}_start_timestamp" "Begining of the scylla ${action} in epoch" "gauge" "${cluster}"  ${timestamp_file} >> ${METRICS_FILE}
  fi

done

for file in $(ls ${TOUCH_DIR}/scylla_*_*_end*);do 

  if [ -f "$file" ];then
    cluster=$(basename $file | awk -F "_" '{print $3}')
    timestamp_file=$(timestamp_file "$file")
    action=$(basename $file | awk -F "_" '{print $2}')
    editMetric "scylla_${action}_end_timestamp" "End of the scylla ${action} in epoch" "gauge" "${cluster}"  ${timestamp_file} >> ${METRICS_FILE}
  fi

done

