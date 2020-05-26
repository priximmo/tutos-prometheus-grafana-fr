%title: Prometheus/Grafana
%author: xavki


# VICTORIAMETRICS : Installation



<br>
* clone du dépôt

```
git clone https://github.com/VictoriaMetrics/VictoriaMetrics.git
```

<br>
* installation de docker (prérequis)

```
curl -fsSL https://get.docker.com | sh; >/dev/null
```

<br>
* création du binaire

```
apt install make
make victoria-metrics-prod
mv bin/victoria-metrics-prod /usr/local/bin/
```

------------------------------------------------------------------------

# VICTORIAMETRICS : Installation

<br>
* création du user/group et directory

```
sudo useradd -rs /bin/false victoriametrics
mkdir -p /var/lib/victoriametrics /run/victoriametrics/
chown victoriametrics:victoriametrics /var/lib/victoriametrics /run/victoriametrics/
```

<br>
* service systemd 

```
[Unit]
Description=VictoriaMetrics
After=network.target
[Service]
User=victoriametrics
Group=victoriametrics
Type=simple
StartLimitBurst=5
StartLimitInterval=0
Restart=on-failure
RestartSec=1
PIDFile=/run/victoriametrics/victoriametrics.pid
ExecStart=/usr/local/bin/victoriametrics -storageDataPath /var/lib/victoriametrics -retentionPeriod 6
ExecStop=/bin/kill -s SIGTERM $MAINPID
[Install]
WantedBy=multi-user.target
[Service]
LimitNOFILE=32000
LimitNPROC=32000
```

------------------------------------------------------------------------


# VICTORIAMETRICS : Installation

<br>
* lancement/init

```
systemctl enable victoriametrics
systemctl start victoriametrics
```

<br>
* configuration de prometheus

```
remote_write:
  - url: "http://127.0.0.1:8428/api/v1/write"
    queue_config:
      max_samples_per_send: 10000
```

* init

```
--storage.tsdb.retention 0m
```

* daemon-reload + restart de prometheus
