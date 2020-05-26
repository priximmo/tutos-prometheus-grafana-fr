%title: Prometheus/Grafana
%author: xavki


# Prometheus : AlertManager


<br>
* objectif : reçoit les alertes et les diffuses (mail, slack, mattermost, pagerduty...)

<br>
* Dépot git :
https://github.com/prometheus/alertmanager/



----------------------------------------------------------------------------------------------------------


# Alertmanager : installation


<br>
* création d'un user

```
useradd --no-create-home --shell /bin/false alertmanager
```


* création d'un répertoire de conf et datas

```
mkdir /etc/alertmanager
mkdir -p /var/lib//alertmanager/data
chown alertmanager:alertmanager /var/lib/alertmanager/data
```

<br>
* download et installation:

```
wget https://github.com/prometheus/alertmanager/releases/download/v0.20.0/alertmanager-0.20.0.linux-amd64.tar.gz 
```

* placer les binaires dans e path

```
cp alertmanager-0.20.0.linux-amd64/alertmanager /usr/local/bin/
cp alertmanager-0.20.0.linux-amd64/amtool /usr/local/bin/
```

* changement des droits 

```
chown alertmanager:alertmanager /usr/local/bin/alertmanager
chown alertmanager:alertmanager /usr/local/bin/amtool
```

----------------------------------------------------------------------------------------------------------

# Alertmanager : configuration


<br>
* edition du fichier de conf

vim /etc/alertmanager/alertmanager.yml

```
global:
  resolve_timeout: 2m
  smtp_require_tls: false

route:
  group_by: ['altername']
  # Send all notifications to me.
  group_wait: 30s
  group_interval: 1m
  repeat_interval: 5s
  receiver: 'email-me'

receivers:
- name: 'email-me'
  email_configs:
  - to: "chaine.xavki@gmail.com"
    from: "chaine.xavki@gmail.com"
    smarthost: "smtp.gmail.com:465"
    auth_username: "chaine.xavki@gmail.com"
    auth_identity: "chaine.xavki@gmail.com"
    auth_password: "Xavki12*"
```

chown alertmanager:alertmanager -R /etc/alertmanager

-------------------------------------------------------------------------------------------------------------

# Alertmanager : systemd


<br>
* alertmanager

vim /etc/systemd/system/alertmanager.service

```
[Unit]
Description=Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=alertmanager
Group=alertmanager
Type=simple
WorkingDirectory=/etc/alertmanager/
ExecStart=/usr/local/bin/alertmanager --config.file=/etc/alertmanager/alertmanager.yml --web.external-url http://0.0.0.0:9093

[Install]
WantedBy=multi-user.target
```

------------------------------------------------------------------------------------------------------------

# Altermanager : prometheus modifications


<br>
* prometheus

```
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries \
    --web.external-url http://192.168.59.2

[Install]
WantedBy=multi-user.target
```

-----------------------------------------------------------------------------------------------------------

# Altermanager : prometheus modifications


<br>
* configuration de prometheus

```
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - localhost:9093
```

```
systemctl daemon-reload
systemctl restart prometheus
systemctl restart alertmanager
```
