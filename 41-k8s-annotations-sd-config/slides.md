%title: Prometheus/Grafana
%author: xavki


# PROMETHEUS : Scrape sur Annotations

<br>

* Vidéo précédente = prometheus operator

<br>

* CRDs > prometheus stack

<br>

* Possibilité d'utiliser les annotations

	Attention : annotations différentes des labels

<br>

* exemple : prometheus = activation scrape + port + path

---------------------------------------------------------------------------------

# PROMETHEUS : Scrape sur Annotations

<br>

```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "9121"
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: redis
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        ports:
        - containerPort: 6379
      - name: redis-exporter
        image: oliver006/redis_exporter:latest
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        ports:
        - containerPort: 9121
```


---------------------------------------------------------------------------------

# PROMETHEUS : Scrape sur Annotations

<br>

```
---
kind: Service
apiVersion: v1
metadata:
  name: redis
spec:
  selector:
    app: redis
  ports:
  - name: redis
    protocol: TCP
    port: 6379
    targetPort: 6379
  - name: prom
    protocol: TCP
    port: 9121
    targetPort: 9121
```

---------------------------------------------------------------------------------

# PROMETHEUS : Scrape sur Annotations


<br>

```
        additionalScrapeConfigs:
          - job_name: 'kubernetes-pods'
            kubernetes_sd_configs:
            - role: pod
            relabel_configs:
            - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
              action: keep
              regex: true
            - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
              action: replace
              target_label: __metrics_path__
              regex: (.+)
            - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]
              action: replace
              regex: ([^:]+)(?::\d+)?;(\d+)
              replacement: $1:$2
              target_label: __address__
            - action: labelmap
              regex: __meta_kubernetes_pod_label_(.+)
            - source_labels: [__meta_kubernetes_namespace]
              action: replace
              target_label: kubernetes_namespace
            - source_labels: [__meta_kubernetes_pod_name]
              action: replace
              target_label: kubernetes_pod_name
```
