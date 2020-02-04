%title: Prometheus/Grafana
%author: xavki


# Prometheus : Postgres Exporter


<br>
* installation postgres

```
apt install postgres-10
```

<br>
* ajout d'un mot de passe pour le user postgres (ou création d'un user dédié)

```
sudo su - postgres
psql
alter user postgres encrypted password 'xavier';
```

* modification du pg_hba

```
host    all             postgres        0.0.0.0/0               md5

service postgresql restart
```


--------------------------------------------------------------------------------------


# PostgreSQL Exporter


<br>
* lancement docker

```
docker run -d --name postgres_exporter -p 9187:9187 --net=host -e DATA_SOURCE_NAME="postgresql://postgres:xavier@localhost:5432/postgres?sslmode=disable" wrouesnel/postgres_exporter
```

<br>

* grafana :

complet :
https://grafana.com/grafana/dashboards/9628
https://grafana.com/grafana/dashboards/3742

moins :
https://grafana.com/grafana/dashboards/455
https://grafana.com/grafana/dashboards/6742


