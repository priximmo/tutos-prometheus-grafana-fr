#!/bin/bash

#####################################################################
#  TITRE: Scylla backups
#
#  DESCRIPTION: Backup of scylla keyspaces
#####################################################################


### Variables #######################################################

TYPE="backup"
CLUSTER=$(awk -F "'" '$1 ~ "^cluster_name:" {print $2}' /etc/scylla/scylla.yaml)
CLUSTER_LOWER=$(echo $CLUSTER  | tr [A-Z] [a-z])
DATA_DIR="/var/lib/scylla/data/"
KEYSPACES=$(ls /var/lib/scylla/data/ | grep -v "system")
DATE=$(date +"%Y%m%d")
#switch to remote storage :)
BACKUP_PATH="/backups/${DATE}/${CLUSTER}/$(hostname)/"
SCYLLA_DIR_LOG=/var/log/scylla/

### Functions #######################################################

take_snapshot(){

  echo $(date +"%Y-%m-%d.%H:%M:%S")" - Start - take snapshot - $1" | tee -a /var/log/scylla/${TYPE}s.log
  nodetool snapshot -t ${DATE}_$1 $1
  echo $(date +"%Y-%m-%d.%H:%M:%S")" - End - take snapshot - $1" | tee -a /var/log/scylla/${TYPE}s.log

}


move_snapshot(){

  echo $(date +"%Y-%m-%d.%H:%M:%S")" - Start - move snapshot - $1"  | tee -a /var/log/scylla/${TYPE}s.log
  SNAP_FILES=$(find /var/lib/scylla/data/$1/*/snapshots/${DATE}_$1/* -type f 2>/dev/null)
  SNAP_FILES_COUNT=$(find /var/lib/scylla/data/$1/*/snapshots/${DATE}_$1/* -type f 2>/dev/null| wc -l)
  i=0

  for file in ${SNAP_FILES};do
    TABLE_NAME=$(echo $file | sed s@/var/lib/scylla/data/$1/@@ | perl -nle 'm{(.*)-[0-9a-z]*/.*};print $1' 2>/dev/null)
    step_date=$(date +"%Y-%m-%d.%H:%M:%S")
    i=$(($i+1))
    echo "$step_date -- file $i / $SNAP_FILES_COUNT : $(basename $file)"  | tee -a /var/log/scylla/${TYPE}s.log
    mkdir -p ${BACKUP_PATH}/$1/${TABLE_NAME}
    rsync -aq $file ${BACKUP_PATH}/$1/${TABLE_NAME}
  done
  echo $(date +"%Y-%m-%d.%H:%M:%S")" - End- move snapshot - $1"  | tee -a /var/log/scylla/${TYPE}s.log

}


clean_snapshot(){

  echo $(date +"%Y-%m-%d.%H:%M:%S")" - Start - clean snapshot $1"  | tee -a /var/log/scylla/${TYPE}s.log
  KS=$1
  nodetool listsnapshots | awk -v ks=$KS '$1 ~ "^20" {system("nodetool clearsnapshot -t "$1)}'
  echo $(date +"%Y-%m-%d.%H:%M:%S")" - End - clean snapshot $1"  | tee -a /var/log/scylla/${TYPE}s.log

}



#####################################################################

mkdir -p ${SCYLLA_DIR_LOG}
echo $(date +"%Y-%m-%d.%H:%M:%S")" - Start - ${TYPE}" | tee -a /var/log/scylla/${TYPE}s.log
touch ${SCYLLA_DIR_LOG}/scylla_${TYPE}_${CLUSTER_LOWER}_start.txt

for keyspace in ${KEYSPACES};do
  take_snapshot $keyspace 
  move_snapshot $keyspace
  clean_snapshot $keyspace
done

touch ${SCYLLA_DIR_LOG}/scylla_${TYPE}_${CLUSTER_LOWER}_end.txt
echo $(date +"%Y-%m-%d.%H:%M:%S")" - End - ${TYPE}" | tee -a /var/log/scylla/${TYPE}s.log


