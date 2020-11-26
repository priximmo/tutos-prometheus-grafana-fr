%title: Prometheus/Grafana
%author: xavki


# Prometheus : export custom


<br>


* exemple : nombre de process worker de nginx


```
printMetric () {
    echo "# HELP $1 $2"
    echo "# TYPE $1 $3"
    echo "$1 $4"
}

NGINX_WORKER_NB=$(ps aux | grep "[n]ginx: worker" | wc -l)

ping -c 4 -q 8.8.8.8                        
if [ "$?" -eq 0 ]; then
DNS_CHECK=1
else                                              
DNS_CHECK=0
fi

printMetric "dns_check" "Check dns access" "gauge" $DNS_CHECK
printMetric "nginx_worker_metrics" "Number of worker process for nginx" "gauge" $NGINX_WORKER_NB

```


