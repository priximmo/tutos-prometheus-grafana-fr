

# Qu'est-ce que Prometheus ?


<br>
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
## Installation d'un node exporter (source)


```
sudo apt-get install prometheus-node-exporter
```
