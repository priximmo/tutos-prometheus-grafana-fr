#!/usr/bin/python3

from flask import Response, Flask, request,jsonify
from prometheus_client import Counter
from prometheus_client import generate_latest,CONTENT_TYPE_LATEST
from random import randint

app = Flask(__name__)


labels = ['clientid']
mycounter = Counter('mycounter_client_orders_total', 'The total number of processed requests', labels)

@app.route("/")
def home():
    orders = []
    for i in range(10000):
      clientid = "a" + str(i)
      number = randint(1,100)
      mycounter.labels(clientid = clientid).inc(number)
      orders.append({clientid:number})
    return jsonify(orders = orders)

@app.route("/metrics")
def requests_count():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
