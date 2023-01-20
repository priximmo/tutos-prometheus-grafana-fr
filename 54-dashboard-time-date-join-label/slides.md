%title: Prometheus/Grafana
%author: xavki


# GRAFANA DASHBOARDS : Join / Time / Date / Label


<br>

```
label_replace(mysql_backup_end_timestamp,"host","$1","instance","(.*):.*") * 1000

(mysql_backup_end_timestamp-mysql_backup_start_timestamp)
```
