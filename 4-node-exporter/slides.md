%title: Prometheus/Grafana
%author: xavki


# Prometheus : configuration + node exporter

* liste exporters : https://github.com/prometheus/prometheus/wiki/Default-port-allocations

Node Exporter : 

* collecte de métriques systèmes :
		- disques
		- mémoire
		- cpu
		- load average
		- nfs
		- time
		- uname
		- vmstat
		- stat (interrupts...)
		- ...

* ajout de node exporter

```
sudo apt-get install prometheus-node-exporter
# si restriction ex :--no-collector.pressure
```

