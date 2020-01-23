%title: Prometheus/Grafana
%author: xavki


# PromQL : Operator

<br>
* conditions

```
    == (equal)
    != (not-equal)
    > (greater-than)
    < (less-than)
    >= (greater-or-equal)
    <= (less-or-equal)
    and (intersection)
    or (union)
    unless (complement)
```

Doc : https://prometheus.io/docs/prometheus/latest/querying/operators/

node_load1 > 1.0 and node_load1<1.6
