%title: Prometheus/Grafana
%author: xavki


# PromQL : Temps

<br>
* Range Vector : [] 
		- cherche tous les timesseries sur un interval de temps
		- par défaut par rapport à maintenant

* Offset : offset 3m
		- change la date à laquelle on recherche la timeseries

* Unités de temps :
    s - seconds
    m - minutes
    h - hours
    d - days
    w - weeks
    y - years

---------------------------------------------------------------


# PromQL : Range Vector


<br>
* données des 3 dernières minutes pour node_cpu_seconds_total :

```
node_cpu_seconds_total[3m]
```

Rq : format date =  699.47 @1574340307.27

* conversion

```
date -d "@1574340307.27"
```

<br>
* sum_over_time : somme dans le temps

```
sum_over_time(node_cpu_seconds_total[3m])
```

* idem average

```
avg_over_time(node_cpu_seconds_total[3m])
```

---------------------------------------------------------

# PromQL : Offset


* offset permet déplacer son point de référence

* idéal pour comparer 2 périodes

sum(http_requests_total)by (code) - sum(http_requests_total offset 5m)by (code)
