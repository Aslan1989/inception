#!/bin/bash
set -e

# Wait for MariaDB
echo "Waiting for MariaDB..."
echo "Waiting for MariaDB..."
until mysqladmin ping -h "mariadb" -u $MYSQL_USER -p$MYSQL_PASSWORD --silent; do
    echo "MariaDB not ready yet..."
    sleep 2
done
echo "MariaDB is ready!"

mkdir -p /var/www/html
cd /var/www/html

# If wp-config.php doesn't exist → conf WordPress
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Setting up WordPress..."

    wp core download --allow-root

    wp config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb \
        --allow-root

    wp core install \
        --url=https://$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=admin@example.com \
        --allow-root

    wp user create $WP_USER $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD \
        --role=author \
        --allow-root
fi


chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Run php-fpm
exec php-fpm8.2 -F
