%title: Prometheus/Grafana
%author: xavki


# PROMETHEUS : Scrape sur Annotations


apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: xavki
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: xavki.kub
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: xavki
            port:
              number: 8080

---
kind: Service
apiVersion: v1
metadata:
  name: xavki
spec:
  selector:
    app: xavki
  ports:
  - name: xavki
    protocol: TCP
    port: 8080
    targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: xavki
spec:
  replicas: 1
  selector:
    matchLabels:
      app: xavki
  template:
    metadata:
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "8080"
      labels:
        app: xavki
    spec:
      containers:
      - name: xavki
        image: priximmo/flaskexporter:v0.1
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        ports:
        - containerPort: 8080

