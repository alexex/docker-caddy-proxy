#!/bin/bash

domain=$VIRTUAL_HOST
port=$SERVER_PORT
email=$ADMIN_EMAIL

config_file=config/caddyfile

mkdir -p $(dirname $config_file)
cat > $config_file << EOF
$domain:80
tls $email

proxy / server:$port {
       proxy_header Host {host}
       proxy_header X-Real-IP {remote}
       proxy_header X-Forwarded-Proto {scheme}

       proxy_header Connection {>Connection}
       proxy_header Upgrade {>Upgrade}
}
EOF

exec /usr/sbin/caddy -conf $config_file $@
