%title: Prometheus/Grafana
%author: xavki


# PromQL : Relabel - label_replace

<br>
* label : élément pour filtrer et typer des métriques (très utiles aussi pour grafana)


----------------------------------------------------------------------------------

# PromQL : Rate


* fonction label_replace

```
label_replace(v instant-vector, dst_label string, replacement string, src_label string, regex string) 
```

<br>

* exemple :

```
label_replace(up, "mylabel", "$1", "job", "(.*)")
```
