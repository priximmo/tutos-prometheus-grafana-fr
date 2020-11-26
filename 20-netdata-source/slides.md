%title: NETDATA
%author: xavki


# Netdata : Backend Prometheus

<br>


* prometheus

```
apt-get update -qq >/dev/null
apt-get install -qq -y wget unzip prometheus >/dev/null
```

* édition de /etc/prometheus/prometheus.yml

* restart du service

```
service prometheus restart
```

* doc netdata : https://docs.netdata.cloud/backends/prometheus/


-------------------------------------------------------------

# Configuration de prometheus

<br>



```
global:
  scrape_interval:     5s
  evaluation_interval: 5s
  external_labels:
    monitor: 'codelab-monitor'
rule_files:
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['0.0.0.0:9090']
  - job_name: 'netdata-scrape'
    metrics_path: '/api/v1/allmetrics?format=prometheus&source=as-collected'
    honor_labels: true
    static_configs:
     - targets: ['192.168.60.2:19999']
```

ex : 

```
netdata_system_cpu_percentage_average{chart="system.cpu",dimension!="idle"}
```

Template grafana : https://grafana.com/grafana/dashboards/7107
