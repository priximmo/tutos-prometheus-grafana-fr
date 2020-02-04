#!/usr/bin/python
from flask import Flask, render_template,request,make_response,jsonify,Response
from time import gmtime, strftime
from prometheus_client import (generate_latest, CONTENT_TYPE_LATEST,Counter,Summary )

app = Flask(__name__)


COUNTER_NOW_EVEN = Counter('nombre_pair',
                           'nombre de secondes paires retournees')
COUNT_FCT_NOW = Summary('nombre_appels_now', 'nombre appels de /now')
COUNT_FCT_HOME = Summary('nombre_appels_home', 'nombre appels de /')


@app.route('/')
@COUNT_FCT_HOME.time()
def bonjour():
    message = "Bienvenue !! \n"
    return message

@app.route('/now')
@COUNT_FCT_NOW.time()
def ws_now():
    """Now service to get date time on the server."""
    if int(strftime("%S", gmtime())) % 2 == 0:
        COUNTER_NOW_EVEN.inc()

    return make_response(jsonify({
        'date': strftime("%Y-%m-%d", gmtime()),
        'hour': strftime("%H:%M:%S", gmtime())
    }), 200)

@app.route('/metrics')
def metrics():
    """Flask endpoint to gather the metrics, will be called by Prometheus."""
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)

