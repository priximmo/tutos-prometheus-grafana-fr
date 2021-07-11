%title: Prometheus/Grafana
%author: xavki


# 40 KUBERNETES : installation prometheus & grafana...

<br>

Installation via une Helm Chart basée sur le prometheus operator

Dépôt : https://github.com/prometheus-community/helm-charts

Attention : persistence de la données (prometheus à minima)

--------------------------------------------------------------

# 40 KUBERNETES : installation prometheus & grafana...

<br>

* NFS - création d'un volume

```
mkdir -p  /srv/provisionner
/srv/provisionner 192.168.12.0/24(rw,sync,no_root_squash,no_subtree_check)
```

<br>

* création d'un namespace nfs

```
kubectl create ns nfs
```

--------------------------------------------------------------

# 40 KUBERNETES : installation prometheus & grafana...

<br>

* NFS - installation d'un provisionner
		* gestion automatique du volume par des répertoires par PVC

```
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: nfs-exporter
  namespace: nfs
spec:
  releaseName: nfs-exporter
  chart:
    name: nfs-subdir-external-provisioner
    version: 4.0.12
    repository: https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
  values:
    nfs:
      server: 192.168.12.20
      path: /srv/provisionner/
```

--------------------------------------------------------------

# 40 KUBERNETES : installation prometheus & grafana...

<br>

* création du namespace monitoring

```
kubectl create ns monitoring
```

--------------------------------------------------------------

# 40 KUBERNETES : installation prometheus & grafana...

<br>

* HR - entête

```
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: prometheus
  namespace: monitoring
spec:
  releaseName: kube-prometheus-stack
  chart:
    name: kube-prometheus-stack
    version: 12.12.1
    repository: https://prometheus-community.github.io/helm-charts
```

--------------------------------------------------------------

# 40 KUBERNETES : installation prometheus & grafana...

<br>

* HR - désactivations (pour pas surcharger car local)

```
  values:
    kubeProxy:
      enabled: false
    kubeEtcd:
      enabled: false
```

--------------------------------------------------------------

# 40 KUBERNETES : installation prometheus & grafana...

<br>

* HR - grafana & ingress

```
    grafana:
      enabled: true
      ingress:
        enabled: true
        hosts:
        - grafana.kub
      adminPassword: xavki
```

--------------------------------------------------------------

# 40 KUBERNETES : installation prometheus & grafana...

<br>

* HR - prometheus & storage class & ingress

```
    prometheus:
      enabled: true
      ingress:
        enabled: true
        ingressClassName: nginx
        hosts:
        - prometheus.kub
      prometheusSpec:
        storageSpec:
          volumeClaimTemplate:
            spec:
              storageClassName: nfs-client
              accessModes: ["ReadWriteOnce"]
              resources:
                requests:
                  storage: 1Gi
```

--------------------------------------------------------------

# 40 KUBERNETES : installation prometheus & grafana...

<br>

* HR - alertmanager & ingress

```
    alertmanager:
      ingress:
        enabled: true
        hosts:
        - alertmanager.kub
```

--------------------------------------------------------------

# 40 KUBERNETES : installation prometheus & grafana...

<br>

* HR : ajustement de configuration (insecure)

```
    kubeControllerManager:
      service:
        port: 10257 # https port
        targetPort: 10257
      serviceMonitor:
        https: true # use https
        insecureSkipVerify: true
    kubeScheduler:
      service:
        targetPort: 10259
        targetPort: 10259
      serviceMonitor:
        https: "true"
        insecureSkipVerify: "true"
```
