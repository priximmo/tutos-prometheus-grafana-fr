%title: Prometheus/Grafana
%author: xavki


# PROMETHEUS : Cardi - app + service monitor selector


<br>

Objectif :

		* monitoré par prom2

		* ne pas monitoré par prom1

------------------------------------------------------------------------------

# PROMETHEUS : Cardi - app + service monitor selector


<br>

* le service monitor

```
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: xavki2
  namespace: xavki
  labels:
    prometheus: prom2
spec:
  endpoints:
  - interval: 30s
    targetPort: 8080
    path: /metrics
    metricRelabelings:
      - sourceLabels: [__name__]
        regex: (^mycounter_client_orders_.*$)
        action: keep
  namespaceSelector:
    matchNames:
    - xavki
  selector:
    matchLabels:
      app: xavki
```

------------------------------------------------------------------------------

# PROMETHEUS : Cardi - app + service monitor selector


<br>

* sur le prometheus 1 (prometheus operator):

```
        serviceMonitorSelector:
          matchExpressions:
            - {key: prometheus, operator: NotIn, values: [prom2]}
```

------------------------------------------------------------------------------

# PROMETHEUS : Cardi - app + service monitor selector


<br>

* création du prometheus 2 :

```
apiVersion: monitoring.coreos.com/v1
kind: Prometheus
metadata:
  name: prometheus-2
  namespace: monitoring
  labels:
    app: prometheus
spec:
  enableAdminAPI: false
  externalUrl: http://prometheus2.kub/
  image: quay.io/prometheus/prometheus:v2.32.1
  listenLocal: false
  logFormat: logfmt
  logLevel: info
  paused: false
  podMonitorNamespaceSelector: {}
  portName: http-web
  probeNamespaceSelector: {}
  prometheusExternalLabelName: ""
  replicas: 1
  retention: 6h
  routePrefix: /
  ruleNamespaceSelector: {}
  securityContext:
    fsGroup: 2000
    runAsGroup: 2000
    runAsNonRoot: true
    runAsUser: 1000
  serviceAccountName: prometheus-operator-kube-p-prometheus
  serviceMonitorNamespaceSelector: {}
  serviceMonitorSelector:
    matchLabels:
      prometheus: prom2
  version: v2.32.1
```

------------------------------------------------------------------------------

# PROMETHEUS : Cardi - app + service monitor selector


<br>

* le service du prometheus 2

```
kind: Service
apiVersion: v1
metadata:
  name: prometheus-2
  namespace: monitoring
  labels:
    app: prometheus
spec:
  selector:
    prometheus: prometheus-2
  ports:
  - name: http-web
    protocol: TCP
    port: 9090
    targetPort: 9090
```

------------------------------------------------------------------------------

# PROMETHEUS : Cardi - app + service monitor selector


<br>

* l'ingress du prometheus 2

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: prometheus
  namespace: monitoring
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: prometheus2.kub
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: prometheus-2
            port:
              number: 9090
```
