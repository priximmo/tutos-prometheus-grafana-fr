%title: Prometheus/Grafana
%author: xavki


# Prometheus : nginx exporter & logs

<br>
* quelques métriques nginx

* très limité

<br>
doc et dépôt : https://github.com/nginxinc/nginx-prometheus-exporter

template grafana : https://github.com/nginxinc/nginx-prometheus-exporter/blob/master/grafana/README.md


----------------------------------------------------------------------------------

# Installation


<br>
* ajout au vhost : 

```
location = /metrics {
    stub_status;
}
```

<br>
* installation de l'exporter (docker ou binaire) :

```
docker run -d --name nginx_exporter -p 9113:9113 nginx/nginx-prometheus-exporter:0.5.0 -nginx.scrape-uri http://172.17.0.1/metrics
```

<br>
* modification de la configuration prometheus :

```
  - job_name: nginx_exporter
    static_configs:
      - targets: ['192.168.59.3:9113']

service prometheus restart
```

<br>
* ajout du template grafana


----------------------------------------------------------------------------------



https://www.martin-helmich.de/en/blog/monitoring-nginx.html
