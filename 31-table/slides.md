%title: Prometheus/Grafana
%author: xavki


# GRAFANA : Table



<br>


count(count(node_cpu_seconds_total) by (instance,cpu))by(instance)
