%title: Prometheus/Grafana
%author: xavki


# Prometheus : PushGateway


https://github.com/prometheus/pushgateway/releases/download/v1.0.0/pushgateway-1.0.0.linux-amd64.tar.gz

tar -xzvf pushgateway-1.0.0.linux-amd64.tar.gz

useradd --no-create-home --shell /bin/false pushgateway

cp pushgateway-1.0.0.linux-amd64/pushgateway /usr/local/bin/

chown pushgateway:pushgateway /usr/local/bin/pushgateway

https://prometheus.io/download/#pushgateway

-------------------------------------------------------------------------------------

cat > /etc/systemd/system/pushgateway.service << EOF
[Unit]
Description=Pushgateway
Wants=network-online.target
After=network-online.target

[Service]
User=pushgateway
Group=pushgateway
Type=simple
ExecStart=/usr/local/bin/pushgateway \
    --web.listen-address=":9091" \
    --web.telemetry-path="/metrics" \
    --persistence.file="/tmp/metric.store" \
    --persistence.interval=5m \
    --log.level="info" \
    --log.format="json"

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

systemctl start pushgateway

-----------------------------------------------------------------------------------------

echo "mymetric 20.25" | curl --data-binary @- http://localhost:9091/metrics/job/my_custom_metrics/instance/xxx.com/provider/hetzner

curl -L http://localhost:9091/metrics/


```
import requests
job_name='my_custom_metrics'
instance_name='10.20.0.1:9000'
provider='hetzner'
payload_key='cpu_utilization'
payload_value='21.90'
response = requests.post('http://localhost:9091/metrics/job/{j}/instance/{i}/team/{t}'.format(j=job_name, i=instance_name, t=team_name), data='{k} {v}\n'.format(k=payload_key, v=payload_value))
print(response.status_code)
````

----------------------------------------------------------------------------------------
