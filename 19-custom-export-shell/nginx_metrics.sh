#!/bin/bash


printMetric () {
    echo "# HELP $1 $2"
    echo "# TYPE $1 $3"
    echo "$1 $4"
}

NGINX_WORKER_NB=$(ps aux | grep "[n]ginx: worker" | wc -l)
printMetric "nginx_worker_metrics" "Number of worker process for nginx" "gauge" $NGINX_WORKER_NB


