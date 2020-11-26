%title: Prometheus/Grafana
%author: xavki


# Prometheus : Nginx VTS


<br>


* ajout interface graphique de nginx (haproxy like)

<br>


* vérifier la présence du module with-http_stub_status_module

```
nginx -V
```

<br>


* sinon compilation nginx 

* download de la version souhaitée

```
cd /opt/ \
    && wget https://nginx.org/download/nginx-1.13.5.tar.gz \
    && tar xf nginx-1.13.5.tar.gz
```

* download du module

```
curl -fSL https://github.com/vozlt/nginx-module-vts/archive/v0.1.15.tar.gz | tar xzf - -C /tmp
```

-------------------------------------------------------------------------------------------------

# Pre compilation


```
apt install make
```

```
apt install libpcre3 libpcre3-dev zlib1g zlib1g-dev
apt install build-essential checkinstall
apt install -y libluajit-5.1-dev libpam0g-dev libssl-dev libluajit-5.1-dev libpam0g-dev libexpat1-dev git curl
```

------------------------------------------------------------------------------------------------

```
./configure \
    --prefix=/etc/nginx \
    --sbin-path=/usr/sbin/nginx \
    --modules-path=/usr/lib/nginx/modules \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --user=nginx \
    --group=nginx \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_stub_status_module \
    --with-http_auth_request_module \
    --with-threads --with-stream \
    --with-stream_ssl_module \
    --with-http_slice_module \
    --with-mail \
    --with-mail_ssl_module \
    --with-file-aio \
    --with-http_v2_module \
    --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2' \
    --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,--as-needed' \
    --add-module=/tmp/nginx-module-vts-0.1.15
```

---------------------------------------------------------------------------------------------

# Compilation & Installation


```
make
make install
addgroup nginx
adduser --system --no-create-home --user-group -s /sbin/nologin nginx
mkdir -p /var/cache/nginx/

cat /lib/systemd/system/nginx.service

[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target

service nginx restart
```



--------------------------------------------------------------------------------------------

# Configuration nginx

```
http {
    ...
    vhost_traffic_status_zone;

```

```
        location /status {
            vhost_traffic_status_display;
            vhost_traffic_status_display_format html;
        }
```

-------------------------------------------------------------------------------------------

# Installation exporter nginx-vts


https://debian.pkgs.org/sid/debian-main-amd64/prometheus-nginx-vts-exporter_0.10.3+git20180501.43b4556+ds-2_amd64.deb.html

wget http://ftp.br.debian.org/debian/pool/main/p/prometheus-nginx-vts-exporter/prometheus-nginx-vts-exporter_0.10.3+git20180501.43b4556+ds-2_amd64.deb

apt install daemon

dpkg -i prometheus-nginx-vts-exporter_0.10.3+git20180501.43b4556+ds-2_amd64.deb




https://hub.docker.com/r/sophos/nginx-vts-exporter/


docker run  -ti --rm --env NGINX_STATUS="http://localhost/status/format/json" sophos/nginx-vts-exporter
