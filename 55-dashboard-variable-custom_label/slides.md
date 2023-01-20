%title: Prometheus/Grafana
%author: xavki


# GRAFANA DASHBOARDS : Bash exporter evol & variables


<br>

label_values(node_os_info,instance)

(sum(node_load1) by (instance) / count(count(node_cpu_seconds_total) by (instance,cpu)) by(instance))
