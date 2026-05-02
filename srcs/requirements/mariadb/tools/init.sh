#!/bin/bash
set -e

echo "Starting MariaDB..."

mysqld_safe &

# Wait for MariaDB
echo "Waiting for MariaDB to start..."
until mysqladmin ping -h "localhost" --silent; do
    sleep 1
done

echo "MariaDB started!"

# Init DB
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo "Database initialized!"

# НЕ ОСТАНАВЛИВАЕМ БАЗУ
# Держим процесс живым
wait
