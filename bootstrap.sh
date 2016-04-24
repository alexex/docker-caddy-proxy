#!/bin/bash

domain=$VIRTUAL_HOST
port=$SERVER_PORT
email=$ADMIN_EMAIL

config_file=config/caddyfile

mkdir -p $(dirname $config_file)
cat > $config_file << EOF
$domain:80

proxy / server:$port
EOF

exec /usr/sbin/caddy -conf $config_file $@
