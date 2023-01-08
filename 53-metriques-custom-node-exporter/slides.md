%title: Prometheus/Grafana
%author: xavki


# NODE-EXPORTER : Custom Metrics & Bash - Ex : backups


<br>

Objectifs ?

	* comment pousser des métriques personnalisées ?

	* des métriques avec un script bash (ou autres)

	* éviter du développement autres langages

	* profiter de node-exporter

	* option de node-exporter --collector.textfile.directory

	* exemple : backups mysql

--------------------------------------------------------------

# NODE-EXPORTER : Custom Metrics & Bash - Ex : backups

<br>

* installation mysql

```
sudo apt install mariadb-server
mysql -e "create database xavki;"
mysql -e "create table xavki.t1 (f1 int, f2 varchar(255));"
```

--------------------------------------------------------------

# NODE-EXPORTER : Custom Metrics & Bash - Ex : backups

<br>

Qu'est-ce qu'il nous faut ?

	* script de backup

	* cron de backup

	* script de génération des métriques

	* cron de génération des métriques
