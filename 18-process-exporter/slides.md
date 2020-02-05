%title: Prometheus/Grafana
%author: xavki


# Prometheus : process_exporter


<br>

```
docker run -d --name process_exporter -p 9256:9256 --privileged -v /proc:/host/proc -v `pwd`:/config ncabatoff/process-exporter --procfs /host/proc -config.path /config/filename.yml
```

