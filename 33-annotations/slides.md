%title: Prometheus/Grafana
%author: xavki


# GRAFANA : Annotations



<br>


* identifier des évènements 
		* ponctuels
		* plage

* exemple : montées de version (CI/CD)

* commun à tous les dashboards
		* attention sélection par tags

---------------------------------------------------------------

# GRAFANA : Annotations

<br>


* API
		* generate token (bearer)
		* curl

curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer <token>" --data "@annotation.json" http://192.168.59.2:3000/api/annotations

```
  {
    "text": "Title",
    "time": 1590351170528,
    "tags": [
      "deployment",
      "env:production",
      "tier:backend"
    ]
  }
```

Rq : temps epoch milliseconds

```
date +%s%3N
```
