#!/usr/bin/bash

###############################################################
#  TITRE: 
#
#  AUTEUR:   Xavier
#  VERSION: 
#  CREATION:  
#  MODIFIE: 
#
#  DESCRIPTION: 
###############################################################



# Variables ###################################################

VERSION=0.26.0


# Functions ###################################################

create_user_dir(){

useradd --no-create-home --shell /bin/false alertmanager
mkdir -p /etc/alertmanager  /var/lib/alertmanager
chown -R alertmanager:alertmanager /var/lib/alertmanager/ /etc/alertmanager

}

install_archive(){

wget -q https://github.com/prometheus/alertmanager/releases/download/v${VERSION}/alertmanager-${VERSION}.linux-amd64.tar.gz
tar xzf alertmanager-${VERSION}.linux-amd64.tar.gz
cp alertmanager-${VERSION}.linux-amd64/alertmanager /usr/local/bin/
cp alertmanager-${VERSION}.linux-amd64/amtool /usr/local/bin/

chmod +x /usr/local/bin/*

}

configuration_file(){

echo "
global:
  resolve_timeout: 2m
  smtp_require_tls: false

route:
  group_by: ['instance', 'severity']
  group_wait: 10s		# temps d'attente avant notification du group
  group_interval: 1m		# délai par rapport aux alertes du même groupe
  repeat_interval: 30s		# attente avant répétition
  receiver: 'email-me'
  routes:
  - match:
      alertname: Trop_2_load

receivers:
  - name: 'null'
  - name: 'email-me'
    email_configs:
    - to: 'xxx@moi.fr'
      from: 'yyy@moi.fr'
      smarthost: '127.0.0.1:2525'

" > /etc/alertmanager/alertmanager.yml

chown alertmanager:alertmanager /etc/alertmanager/alertmanager.yml

}

systemd_service(){

echo "
[Unit]
Description=Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=alertmanager
Group=alertmanager
Type=simple
WorkingDirectory=/etc/alertmanager/
ExecStart=/usr/local/bin/alertmanager --storage.path=/var/lib/alertmanager/ --config.file=/etc/alertmanager/alertmanager.yml --web.external-url http://0.0.0.0:9093

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/alertmanager.service

}

start_enable_service(){

systemctl start alertmanager
systemctl enable alertmanager

}

install_fake_smtp(){

docker run -p 8080:80 -p 2525:25 -d --name smtpdev rnwood/smtp4dev

}

install_karma(){

docker run -d --name karma -p 8081:8080 -e ALERTMANAGER_URI=http://172.17.0.1:9093 ghcr.io/prymitive/karma:latest

}

# Let's Go !! #################################################

install_fake_smtp
create_user_dir
install_archive
configuration_file
systemd_service
start_enable_service
install_karma
