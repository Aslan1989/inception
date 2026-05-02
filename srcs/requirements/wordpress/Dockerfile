# syntax=docker/dockerfile:1
FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php-fpm php-mysql curl \
    && rm -rf /var/lib/apt/lists/*

# Ставим wp-cli (удобно для автоматической настройки)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Конфиг php-fpm
COPY conf/www.conf /etc/php/*/fpm/pool.d/www.conf

# Init-скрипт
COPY tools/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/init.sh"]
