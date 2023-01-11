%title: Prometheus/Grafana
%author: xavki


# GRAFANA DASHBOARDS : Join / Time / Date / Label


<br>


(sum(node_load1) by (instance) / count(count(node_cpu_seconds_total) by (instance,cpu)) by(instance))
