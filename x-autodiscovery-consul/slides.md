%title: Prometheus/Grafana
%author: xavki


# PromQL : Filtre sur les labels


* équivalent à une clause WHERE

* utilise les regex GO

* labels fournis par la source ou retager par prometheus (prometheus.yml)

ex :

```
scrape_configs:
  - job_name: Consul
    consul_sd_configs:
      - server: '192.168.57.10:8500'
        datacenter: 'mydc'
    relabel_configs:
      - source_labels: [__meta_consul_service]
        target_label: job
```


---------------------------------------------------------------------------------


# Filtres


<br>


* exemple simple (à partir de node exporter)

```
node_network_receive_bytes_total{device="eth0"}
```

<br>


* différent de

```
node_network_receive_bytes_total{device!="eth1"}
```


<br>


* exemple regex

```
node_network_receive_bytes_total{device=~"eth.+"}
node_network_receive_bytes_total{device=~"eth0|lo"}
```

<br>


* multiple filtres

```
node_network_receive_bytes_total{instance="xxxx",device=~"eth.+"}
```

