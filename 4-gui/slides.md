%title: Prometheus/Grafana
%author: xavki


# Prometheus : définitions et configuration


<br>
* fichier yaml :

```
./prometheus --config.file=prometheus.yml
```

* configuration :
	* global : configurations qui s'appliquent en général
		* scrape_interval (ou job) : intervale de récupération des données
		* evaluation_interval (ou job) : réévaluation des rules (alertes)
		* scrape_timeout (ou job) : timeout lors du scraping

	* rule_files: configuration des alertes

	* scrape_configs : configuration particulière du scraping
		* job_name : nom de bloc
		* metrics_path: route de scraping (/metrics)
		* static_config:
				* labels: définition de labels (important pour grafana / standardiser)
					* targets : url/ip:ports

<br>
* Définitions : jobs et instances

		* job_name = job
		* instance = target (ip:port)

```
up{job="<job-name>", instance="<instance-id>"}
up{instance="192.168.62.3:9100",job="node_exporter",service="myapp"}
```

* Définitions : metrics
		* ex : node_cpu_seconds_total{cpu="0",mode="iowait"} 0.3
		* <prefix_app>_<nom>_<unit>_<calcul>{<label>="<valeur>",...} <valeur_metrics>				

[Best practices metrics](https://prometheus.io/docs/practices/naming/)
