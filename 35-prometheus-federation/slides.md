%title: Prometheus/Grafana
%author: xavki


# PROMETHEUS : Fédérations



<br>
* rassembler plusieurs prometheus en 1 

* filtre sur label

* fréquence de scrape

Doc : https://prometheus.io/docs/prometheus/latest/federation/

<br>
* sur les prometheus "sources" / filtre external label

```
global:
  scrape_interval:     5s
  evaluation_interval: 5s
  external_labels:
    datacenter: "dc-xavki-1"
rule_files:
scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets: ['localhost:9090']
  - job_name: node_exporter
    static_configs:
      - targets: ['192.168.59.3:9100']
```

---------------------------------------------------------------

# PROMETHEUS : Fédérations


<br>
* sur le prometheus "collecteur"

```
  - job_name: 'federate'
    scrape_interval: 15s
    honor_labels: true
    metrics_path: '/federate'
    params:
      'match[]':
        - '{job="node_exporter"}'
        - '{__name__=~"datacenter:.*"}'
    static_configs:
      - targets:
        - '192.168.59.4:9090'
        - '192.168.59.5:9090'
```
