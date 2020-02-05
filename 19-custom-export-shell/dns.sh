#!/bin/bash


printMetric () {
    echo "# HELP $1 $2"
    echo "# TYPE $1 $3"
    echo "$1 $4"
}
ping -c 2 -q 8.8.8.8 >/dev/null
if [ "$?" -eq 0 ]; then
DNS_CHECK=1
else
DNS_CHECK=0
fi
printMetric "dns_check" "Check dns access" "gauge" $DNS_CHECK

