%title: Prometheus/Grafana
%author: xavki


# PROMETHEUS : Service Monitor


<br>

* service dédié au monitoring... ;)

* permet de ne pas passer par les annotations

* permet d'être plus complet dans les spécifications du scrape

* service monitor sélectionne des services

* attention aux selectors :
		* du prometheus - cf conf de la ressource
		* du service monitor (cf exemple

* plus complexe que les annotations + plus complet aussi (cf exemple)
		* utilisable de manière transparente avec helm

--------------------------------------------------------------------------

# PROMETHEUS : Service Monitor

<br>

* simple exemple:

```
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: redis
  namespace: redis
spec:
  endpoints:
  - interval: 5s
    targetPort: 9121
    path: /metrics
  namespaceSelector:
    matchNames:
    - redis
  selector:
    matchLabels:
      app: redis
```

----------------------------------------------------------------------------

# PROMETHEUS : Service Monitor

<br>

* avec relabel :

```
  endpoints:
  - interval: 5s
    targetPort: 9121
    path: /metrics
    metricRelabelings:
      - sourceLabels: [pod]
        targetLabel: pod
        regex: (.*)
        replacement: "pod-redis-${1}"
        action: replace
```

