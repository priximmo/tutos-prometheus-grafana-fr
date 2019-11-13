%title: Prometheus/Grafana
%author: xavki


# Qu'est-ce que Prometheus ?


[Dépôt Git](https://github.com/prometheus/prometheus)

[Site Officiel](https://prometheus.io/)

<br>
* langage : GO

* base time series + serveur web + moteur

<br>
* collecte de données à fréquence régulière (scraping)

<br>
* très bonne répartition entre mémoire et disque

<br>
* scrape d'une route exposée : /metrics (défaut sur port 9090)

<br>
* principe de stockage : clef / timestamp / valeur

<br>
* double delta possible pour limiter la place : écart par rapport à la valeur précédente

<br>
* possibilité de discovery via des registry (consul...)

-------------------------------------------------------------------------------------------


# Installation de prometheus


<br>
## Paquet Debian

```
sudo apt-get install prometheus
```

<br>
## Configuration 

```
/etc/prometheus/prometheus.yml
```

<br>
## Reload de configuration

```
curl -X POST http://localhost:9090/-/reload
```

<br>
## Accès 

```
localhost:9090
```

<br>
## Docker


```
docker run -d --name prometheus \
-v $PWD/etc/:/etc/prometheus/ \
 -v $PWD/data/:/prometheus/ \
-p 9090:9090 quay.io/prometheus/prometheus:v2.0.0
```


