#!/bin/bash
set -e

# Run temp server
mysqls_safe --skip-networking &
pid="$!"

# Wait, while MariaDB starts
echo "Waiting for MariaDB to start..."
until mysqladmin ping -h "localhost" --silent; do
	sleep 1
done

# Init
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

#Stops temp server
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Run MariaDB in foreground (PID 1 - right for Docker)
exec mysqld_safe
