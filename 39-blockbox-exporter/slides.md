%title: Prometheus/Grafana
%author: xavki


# PROMETHEUS : Blackbox exporter



<br>
* download du binaire :

```
wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.17.0/blackbox_exporter-0.17.0.linux-amd64.tar.gz
tar xzvf blackbox_exporter-0.17.0.linux-amd64.tar.gz
sudo mv blackbox_exporter-0.17.0.linux-amd64/blackbox_exporter /usr/bin/
```


<br>
* création directory et user

```
sudo useradd -rs /bin/false blackbox
sudo mkdir /etc/blackbox_exporter/
sudo chmod 755 /etc/blackbox_exporter/
sudo chown blackbox /etc/blackbox_exporter/
```

<br>
* création du service systemd /etc/systemd/system/blackbox_exporter.service

```
[Unit]
Description=Blackbox Exporter
After=network-online.target
[Service]
User=blackbox
Group=blackbox
Type=simple
ExecStart=/usr/bin/blackbox_exporter
[Install]
WantedBy=multi-user.target
```

```
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
```


<br>
* prometheus configuration 

```
- job_name: blackbox
  metrics_path: /probe
  params:
    module: [http_2xx]
  static_configs:
   - targets:
      - https://www.robustperception.io/
      - http://prometheus.io/blog
  relabel_configs:
   - source_labels: [__address__]
     target_label: __param_target
   - source_labels: [__param_target]
     target_label: instance
   - target_label: __address__
     replacement: 192.168.13.41:9115 
```

```
modules:
  http_2xx:
    prober: http
    http:
  http_post_2xx:
    prober: http
    http:
      method: POST
```

```
modules:
  http_2xx:
    prober: http
    timeout: 5s
    http:
      valid_http_versions: ["HTTP/1.1", "HTTP/2.0"]
      valid_status_codes: []  # Defaults to 2xx
      method: GET
      headers:
        Accept-Language: en-US
      no_follow_redirects: false
      fail_if_ssl: true
      fail_if_not_ssl: false
      fail_if_body_matches_regexp:
        - "Could not connect to database"
      fail_if_body_not_matches_regexp:
        - "Download the latest version here"
      fail_if_header_matches: # Verifies that no cookies are set
        - header: Set-Cookie
          allow_missing: true
          regexp: '.*'
      fail_if_header_not_matches:
        - header: Access-Control-Allow-Origin
          regexp: '(\*|example\.com)'
      tls_config:
        insecure_skip_verify: false
      preferred_ip_protocol: "ip4" # defaults to "ip6"
      ip_protocol_fallback: false  # no fallback to "ip6"

```
