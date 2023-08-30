#!/bin/bash

#####################################################################
#  TITRE: Scylla repairs
#
#  DESCRIPTION: Backup of scylla keyspaces
#####################################################################


### Variables #######################################################

TYPE="repair"
CLUSTER=$(awk -F "'" '$1 ~ "^cluster_name:" {print $2}' /etc/scylla/scylla.yaml)
CLUSTER_LOWER=$(echo $CLUSTER  | tr [A-Z] [a-z])
DATE=$(date +"%Y%m%d")
SCYLLA_DIR_LOG=/var/log/scylla/

### Functions #######################################################

run_repair(){

  nodetool repair --full

}

#####################################################################

mkdir -p ${SCYLLA_DIR_LOG}
echo $(date +"%Y-%m-%d.%H:%M:%S")" - Start - ${TYPE}" | tee -a /var/log/scylla/${TYPE}s.log
touch ${SCYLLA_DIR_LOG}/scylla_${TYPE}_${CLUSTER_LOWER}_start.txt

run_repair 

touch ${SCYLLA_DIR_LOG}/scylla_${TYPE}_${CLUSTER_LOWER}_end.txt
echo $(date +"%Y-%m-%d.%H:%M:%S")" - End - ${TYPE}" | tee -a /var/log/scylla/${TYPE}s.log
