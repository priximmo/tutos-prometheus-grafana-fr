%title: Prometheus/Grafana
%author: xavki


# VICTORIAMETRICS : stockage longue durée



<br>
* TSBD : stockage à froid / long terme

* Stockage longue durée pour prometheus (et pas que)

* GO / Opensource / Ukraine / 2018

* Site : https://victoriametrics.com/

* Github : https://github.com/VictoriaMetrics/VictoriaMetrics

* Quelques grands noms : Adidas, CERN, Wix, Synthesio...

* PromQL > grafana

------------------------------------------------------------------------------------------

# VICTORIAMETRICS : stockage longue durée


<br>
* Pourquoi ? 
https://medium.com/@valyala/when-size-matters-benchmarking-victoriametrics-vs-timescale-and-influxdb-6035811952d4

```
  VictoriaMetrics — 1.7M datapoints per second, RAM usage — 0.8GB, data size on HDD — 387MB.
  InfluxDB — 1.1M datapoints per second, RAM usage — 1.7GB, data size on HDD — 573MB.
  Timescale — 890K datapoints per second, RAM usage — 0.4GB, data size on HDD — 29GB.
```

Rq: outil de benchmarck de TSDB https://github.com/timescale/tsbs

<br>
* centralisation de plusieurs prometheus
