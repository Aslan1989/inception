#!/bin/bash
set -e

mkdir -p /etc/nginx/ssl

# Generate selfasignment sertificat
openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=DE/ST=HE/L=Marburg/O=42/OU=Inception/CN=${DOMAIN_NAME}"

# Run nginx (Important: without daemon)
exec nginx -g "daemon off;"
