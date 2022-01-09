%title: Prometheus/Grafana
%author: xavki


# PROMETHEUS : Scrape sur Annotations


<br>

https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/

<br>

```
#/etc/prometheus/prometheus.yml
rule_files:
  - "rules.yml"
```

```
#/etc/prometheus/rules.yml
groups:
  - name: mycounter2
    rules:
    - record: rule_mycounter2
      expr: sum by (app) (sum(mycounter_client_orders_total)by(app))
```

----------------------------------------------------------------------------------------

# PROMETHEUS : Scrape sur Annotations

<br>

* grâce au prometheus operator

```
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  annotations:
    prometheus-operator-validated: "true"
  labels:
    app: kube-prometheus-stack
    release: kube-prometheus-stack
  name: mycounter
  namespace: monitoring
spec:
  groups:
  - name: mycounter
    rules:
    - expr: sum(mycounter_client_orders_total)by(app)
      record: 'rule_mycounter'
```
