%title: Prometheus/Grafana
%author: xavki


# GRAFANA : Prometheus Annotations



<br>


* trigger déclenché par prometheus (pas par alermanager)

* cf vidéo 23 : rules prometheus

* configuration :
		* datasource : prometheus
		* enabled
		* Search expression : ALERTS{alertstate="firing"}
		* Title : {{alertname}} - {{instance}}
		* text : liens etc
		* tags


