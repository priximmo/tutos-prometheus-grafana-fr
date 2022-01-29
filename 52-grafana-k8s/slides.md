%title: Prometheus/Grafana
%author: xavki


# GRAFANA : dashboard en configmap


<br>

Intérêts ?

		* versionner

		* intégrer dans un gitops

		* automatiser


--------------------------------------------------------------

# GRAFANA : dashboard en configmap



<br>

* entête de la configmap


```
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-dashboard-xavki
  namespace: monitoring
  labels:
    apps: prometheus-operator-grafana
    grafana_dashboard: "1"
data:
  xavki.json: |-
```
