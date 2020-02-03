#!/bin/bash
# small http wrapper for bash scripts via xinetd

ulimit -n 20480
ulimit -l 512

root='/opt/scripts/'
file="$1"
mime='text/plain'

cd $root

printf 'HTTP/1.1 200 OK\r\nDate: %s\r\nContent-Type: %s\r\nConnection: close\r\n\r\n' "$(date)" "$mime"

for script in /opt/scripts/*.sh;do
  if [ -f "$script" ]; then
    namescript=$(basename ${script} | sed s/.sh//g)
    $script > /tmp/.$namescript.output

    size=$(stat -c "%s" "/tmp/.$namescript.output")

    cat /tmp/.$namescript.output

    sleep 0.1
    rm -f /tmp/.$namescript.output
  fi
done
exit 0
