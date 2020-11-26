%title: Prometheus/Grafana
%author: xavki


# Prometheus : Haproxy


<br>


```
apt install haproxy

defaults
  mode http
  timeout server 5s
  timeout connect 5s
  timeout client 5s
frontend stats
    bind *:8181
    stats enable
    stats uri /stats
    stats refresh 5s
frontend frontend
  bind *:1234
  use_backend backend
backend backend
  server srv1 127.0.0.1:8080
  server srv2 127.0.0.1:8888

python -m SimpleHTTPServer 8080
python -m SimpleHTTPServer 8888
```


-------------------------------------------------------------------------

# Haproxy_Exporter


<br>


https://github.com/prometheus/haproxy_exporter

<br>


* se base sur l'interface graphique format csv

http://192.168.59.3:8181/stats;csv


<br>


* run exporter :

```
docker run -d --name node_exporter -p 9101:9101 quay.io/prometheus/haproxy-exporter:v0.9.0 --haproxy.scrape-uri="http://192.168.59.3:8181/stats;csv"
```

* configuration de prometheus :

```
  - job_name: hapoxy
    static_configs:
      - targets: ['192.168.59.3:9101']
```

* ajout d'un dashboard grafana


https://grafana.com/grafana/dashboards/2428
