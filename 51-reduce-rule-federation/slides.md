%title: Prometheus/Grafana
%author: xavki


# PROMETHEUS : Cardi - rules + fédération


<br>

Objectif :

		* ajouté rule sur prom2

		* supprimé rule sur prom1

		* ajouter une fédération

------------------------------------------------------------------------------

# PROMETHEUS : Cardi - rules + fédération


<br>

* suppression de la rule dans prom1

```
        ruleSelector:
          matchExpressions:
            - {key: prometheus, operator: NotIn, values: [prom2]}
```

------------------------------------------------------------------------------

# PROMETHEUS : Cardi - rules + fédération


<br>

* ajout de la rule dans prom2

```
  ruleSelector:
    matchLabels:
      prometheus: prom2
```

------------------------------------------------------------------------------

# PROMETHEUS : Cardi - rules + fédération


<br>

* création de la rule

```
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  labels:
    prometheus: prom2
  name: xavki
  namespace: monitoring
spec:
  groups:
  - name: xavki
    rules:
      - expr: 'sum(mycounter_client_orders_total) by (service)'
        record: rule_orders_total
```


------------------------------------------------------------------------------

# PROMETHEUS : Cardi - rules + fédération


<br>

* ajout de la fédération :

```
        additionalScrapeConfigs:
          - job_name: federate-prometheus2
            scrape_interval: 30s
            honor_labels: true
            metrics_path: '/federate'
            params:
              'match[]':
              - '{__name__=~"rule_.*"}'
            static_configs:
              - targets:
                - 'prometheus-2.monitoring.svc.cluster.local:9090'
```
