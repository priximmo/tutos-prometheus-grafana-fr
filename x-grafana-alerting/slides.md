%title: Prometheus/Grafana
%author: xavki


# GRAFANA : Alertes



<br>
* exemple avec slack.com

* création d'un channel dans slack

* ajout d'un incoming-webhook
		* apps > incomming-webhook > add > choose channel > settings

* activation alerting dans grafana
		
```
[alerting]
# Disable alerting engine & UI features
enabled = true
# Makes it possible to turn off alert rule execution but alerting UI is visible
execute_alerts = true
```

-----------------------------------------------------------------

# GRAFANA : Alertes

<br>
* ajout d'une alerte

<br>
* GUI : ajouter une destination (slack)
	* alerting > notification channel > new

<br>
* créer un dashboard

* ajouter un panel

* alert : 
	* rule : fréquence/durée
	* condition : au-dessus/en-dessous
	* sélectionner la notification channel

<br>
* test
