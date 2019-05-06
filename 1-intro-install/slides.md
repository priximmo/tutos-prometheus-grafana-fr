

# Qu'est-ce que Prometheus ?

* base time series + serveur web + moteur

* collecte de données à fréquence régulière

* très bonne répartition entre mémoire et disque

* scrape d'une route exposée : /metrics

* principe de stockage : clef / timestamp / valeur

* double delta possible pour limiter la place : écart par rapport à la valeur précédente

-------------------------------------------------------------------------------------------


# Comment l'installer ?


## Installation de la base centrale


```
sudo apt-get install prometheus
```


## Installation d'un node exporter


```
sudo apt-get install prometheus-node-exporter
```

## Configuration

```
/etc/prometheus/prometheus.yml
```

## Reload de configuration

```
curl -X POST http://localhost:9090/-/reload
```

## Accès 

```
localhost:9090
```

