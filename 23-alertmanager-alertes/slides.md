%title: Prometheus/Grafana
%author: xavki


# AlertManager/Prometheus : Alertes


<br>


* les règles d'alertes = prometheus

* les règles de notifications = alertmanager




----------------------------------------------------------------------------------------------------------


# Prometheus : alertes/rules


<br>


* 2 types de rules : précalculs et les alertes

recording (précalculs) : https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/

alerting (alertes) : https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/

<br>


Alerting rules :

* définitions :

	* group : regroupement d'alertes auxquelles on applique les mêmes règles (intervalles...)
		* un nom

	* rules : composé de différentes alertes (définition de caractéristiques communes : labels...)

	* alert : spécifications d'une alert
		* expr : évaluation de la métrique
		* for : durée
		* labels
		* annotations : détails sur l'alerte (résumé et description > aide à la résolution)


-------------------------------------------------------------------------------------------------------------

# Prometheus : alertes/rules


* création d'un répertoire de règles :

```
mkdir /etc/prometheus/rules
chown -R prometheus:prometheus /etc/prometheus/ 
```

* configuration d'une rules

```
groups:
  - name: test
    rules:
    - alert: Trop_2_load
      expr: node_load1 >= 0.6
      for: 10s
      labels:
        severity: critical
      annotations:
        summary: "{{ $labels.instance }} - trop de load"
        description: "Le server en prend plein la tronche "
```

* test

```
promtool check rules /etc/prometheus/rules/alertes.yml
curl -X POST http://localhost:9090/-/reload
```


---------------------------------------------------------------------------------------------------


# AlertManager : alertes/rules


* configuration : /etc/alertmanager/alertmanager.yml

```
global:				# génériques
  resolve_timeout: 2m
  smtp_require_tls: false

route:				# règles de déclenchement
  group_by: ['instance', 'severity']
  group_wait: 10s		# temps d'attente avant notification du group
  group_interval: 1m		# délai par rapport aux alertes du même groupe
  repeat_interval: 5s		# attente avant répétition
  receiver: 'email-me'
  routes:
  - match:
      alertname: Trop_2_load

receivers:
- name: 'email-me'
  email_configs:
  - to: "chaine.xavki@gmail.com"
    from: "chaine.xavki@gmail.com"
    smarthost: "smtp.gmail.com:465"
    auth_username: "chaine.xavki@gmail.com"
    auth_identity: "chaine.xavki@gmail.com"
    auth_password: "Xavki12*"
```

```
service alertmanager restart
```

