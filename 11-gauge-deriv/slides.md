%title: Prometheus/Grafana
%author: xavki


# PromQL : deriv pour gauge

<br>
* metrics :
	* counter : valeur incrémentée
	* gauge : valeur instantanée

```
# HELP node_load1 1m load average.
# TYPE node_load1 gauge
node_load1 0
```

<br>

* uniquement pour la gauges

* deriv : dérivée, augmentation par seconde (équivalent du rate pour les gauges)

* delta : différence entre 2 timestamps

----------------------------------------------------------------------------------

# PromQL : Delta


* delta = (ValueX - Value1) 

```
delta(node_load1[1m])
```

<br>
# PromQL : Deriv

* deriv = (ValueX - Value1) / (TimeX - Time1)

* par unité de temps (secondes)

* utile pour des estimations

```
deriv(node_load1[1m])
```


----------------------------------------------------------------------------------

# Histogram


https://www.robustperception.io/how-does-a-prometheus-histogram-work
