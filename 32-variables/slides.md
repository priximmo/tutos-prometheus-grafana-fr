%title: Prometheus/Grafana
%author: xavki


# GRAFANA : Variables



<br>



node_load1{instance=~"$server:9100"}

node_filesystem_free_bytes{instance=~"$server:9100"}/1024/1024/1024
