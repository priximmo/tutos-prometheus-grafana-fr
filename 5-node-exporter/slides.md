%title: Prometheus/Grafana
%author: xavki


# Prometheus : configuration + node exporter


<br>
* liste exporters : https://github.com/prometheus/prometheus/wiki/Default-port-allocations

* doc node exporter : https://github.com/prometheus/node_exporter

* binaire : https://prometheus.io/download/#node_exporter

<br>
Node Exporter : 

* collecte de métriques systèmes :
		- disques
		- mémoire
		- cpu
		- load average
		- nfs
		- time
		- uname
		- vmstat
		- stat (interrupts...)
		- ...

--------------------------------------------------------------------

# Node exporter : installation


<br>
* ajout de node exporter

```
sudo apt-get install prometheus-node-exporter
# si restriction ex :--no-collector.pressure
```

Rq : pas forcément à jour

<br>
* avec docker

```
docker run -d \
  --net="host" \
  --pid="host" \
  -v "/:/host:ro,rslave" \
  -p 9100:9100 \
  --name node_exporter \
  quay.io/prometheus/node-exporter \
  --path.rootfs=/host
```

---------------------------------------------------------------------

# Node exporter : installation binaire

* preparation 

```
sudo useradd -rs /bin/false node_exporter
https://prometheus.io/download/#node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar -xvzf node_exporter-0.18.1.linux-amd64.tar.gz
mv node_exporter-0.18.1.linux-amd64/node_exporter /usr/local/bin/
chown node_exporter:node_exporter /usr/local/bin/node_exporter
```

* systemd : /etc/systemd/system/node_exporter.service

```
[Unit]
Description=Node Exporter
After=network-online.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target
```

```
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
```


---------------------------------------------------------------------

# Prometheus : configuration


<br>
* ajout du noeud

```
  - job_name: node-exporter
    static_configs:
      - targets: ['localhost:9090']
```

