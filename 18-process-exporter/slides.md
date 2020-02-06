%title: Prometheus/Grafana
%author: xavki


# Prometheus : process_exporter


<br>
* principe : filtre sur les process (source /proc)

--------------------------------------------------------------------------------------------------

# Configuration

<br>
* default

```
process_names:
  - name: "{{.Comm}}"
    cmdline:
    - '.+'
```

<br>
* nom de process : /proc/xxx/stat
```
process_names:
  - comm:
    - dockerd
```

* filtre :

```
process_names:
  - exe:
    - /bin/sh
    cmdline:
    - '.*--2.*'
```

<br>

```
    {{.Comm}} contains the basename of the original executable, i.e. 2nd field in /proc/<pid>/stat
    {{.ExeBase}} contains the basename of the executable
    {{.ExeFull}} contains the fully qualified path of the executable
    {{.Username}} contains the username of the effective user
    {{.Matches}} map contains all the matches resulting from applying cmdline regexps
    {{.PID}} contains the PID of the process. Note that using PID means the group will only contain a single process.
    {{.StartTime}} contains the start time of the process. 
```

--------------------------------------------------------------------------------------------------------

# Process Exporter : installation


<br>
* installation

```
wget https://github.com/ncabatoff/process-exporter/releases/download/v0.6.0/process-exporter_0.6.0_linux_amd64.deb
dpkg -i process-exporter_0.6.0_linux_amd64.deb
mkdir -p /etc/process-exporter/
vim /etc/process-exporter/config.yml
```


<br>

```
docker run -d --name process_exporter -p 9256:9256 --privileged -v /proc:/host/proc -v `pwd`:/config ncabatoff/process-exporter --procfs /host/proc -config.path /config/filename.yml
```

--------------------------------------------------------------------------------------------------------

# Grafana


249
8378
