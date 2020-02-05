%title: Prometheus/Grafana
%author: xavki


# GRAFANA : installation et configuration


<br>
* via dépôt apt

```
sudo wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
apt-get update -qq >/dev/null
apt-get install -qq -y grafana >/dev/null
service grafana-server start
systemctl enable grafana-server
```
---------------------------------------------------------------------

# GRAFANA : installation et configuration


<br>
* via docker

```
version: '3'
services:
  grafana:
    image: grafana/grafana
    container_name: grafana
    user: 0:0
    ports:
     - 3000:3000
    volumes:
     - grafana_data:/var/lib/grafana
     - grafana_etc:/etc/grafana/provisioning/
    networks:
     - generator
volumes:
  grafana_etc:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/grafana/etc/
  grafana_data:
    driver: local
    driver_opts:
      o: bind
      type: none
      device: ${DIR}/grafana/data/
networks:
  generator:
   driver: bridge
   ipam:
     config:
       - subnet: 192.168.168.0/24
```
