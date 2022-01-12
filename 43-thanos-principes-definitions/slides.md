%title: Prometheus/Grafana
%author: xavki


# PROMETHEUS & THANOS : Principes & Définitions


<br>

Site : https://thanos.io/
Github : https://github.com/thanos-io/thanos

<br>

Prometheus :

	* stockage courte durée (consommation de ressources)

	* pas de haut disponibilité avec partitionnement

	* possibilité de fédération

	* fédération même problématique de ressources

	* ha via nombre de réplicas = nécessité de déduplication

	* centralisation de multiple prometheus

	* pas de stockage sans limitation

	* pas de cache de requête

Solution partiel = Thanos

Autres solutions : Victoria Metrics, Cortex...

-----------------------------------------------------------------------------------

# PROMETHEUS & THANOS : Principes & Définitions


<br>

```
https://banzaicloud.com/img/blog/thanos-operator/thanos-single-cluster.png
https://miro.medium.com/max/1000/1*-DyHMDxAOFyL2r5-8DeHpA.png
```

<br>

Thanos Sidecar :

		* tourne à côté du prometheus

		* connecté à un stockage S3

		* utilisation de la Store API (gRPC) au-dessus de prometheus

		* échange entre le prometheus et le querier

		* fréquence 2h (rétention prometheus x3  ~ 6h)

		* (risque perte de 2h de data si crash du prometheus

		* limitation par le nombre de réplicas ou remote write (thanos receiver)

		* dispose aussi en option d'un reloader sur changement de conf prometheus

-----------------------------------------------------------------------------------

# PROMETHEUS & THANOS : Principes & Définitions


<br>

Thanos Store ou Store Gateway :

		* nombreux composants équipés d'une Store API (sidecar, ruler, query

		* connexion directe avec le stockage objet (S3) comme sidecar

		* possibilité de sharder par range de temps

<br>

Thanos Compactor :

		* retravaille les données sur le stockage objet

		* diminution de la précision

		* diminution de la ressource consommée


<br>

Thanos Ruler :

		* identique aux recording rules de prometheus

		* permet de vérifier des règles et de déclencher des alertes (via alerte manager)


-----------------------------------------------------------------------------------

# PROMETHEUS & THANOS : Principes & Définitions


<br>

Thanos Query :

		* interprète le promql fournit

		* dispatch les requêtes  via Store API à chaque store (sidecars, store, autres querier...)

		* réalise la déduplication des métriques (si plusieurs réplicas, ou sidecar + store)

		* https://thanos.io/tip/img/querier.svg

<br>

Thanos Query Frontend :

		* éclate les requêtes complexes et larges

		* met à disposition un cache de requêtes



