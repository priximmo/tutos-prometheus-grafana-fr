%title: Prometheus/Grafana
%author: xavki


# PromQL : Increase vs Rate pour Counter

<br>
* metrics :
	* counter : valeur incrémentée
	* gauge : valeur instantanée


<br>
* 2 fonctions très utiles et utilisées

* travail sur une période de temps

* analyse de tendance/évolution

* rate : taux d'accroisement par seconde

* increase : augmentation sur une période


----------------------------------------------------------------------------------

# PromQL : Rate


* taux = (ValueX - Value1) / (TimeX - Time1)

* calcul d'une évolution moyenne sur une période donnée

* exemple sur 5 secondes : rate(metrics[5s])

<br>

# PromQL : Increase


* augmentation = taux x nombre périodes

* exemple : increase(metrics[5s]) = rate(metrics[5s]) x 5s

<br>
# Demo

```
node_network_receive_bytes_total{device="enp0s8"}
node_network_receive_bytes_total{device="enp0s8"}[1m]
rate(node_network_receive_bytes_total{device="enp0s8"}[1m])
increase(node_network_receive_bytes_total{device="enp0s8"}[1m])
rate(node_network_receive_bytes_total{device="enp0s8"}[1m]) * 60
```
