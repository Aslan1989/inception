# syntax=docker/dockerfile:1
FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copy conf and init-script
COPY conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

# open port inside container (in compose outsode don't publish)
EXPOSE 3306

# IMPORTANT: no sleep/while true - run through our script
ENTRYPOINT ["/usr/local/bin/init.sh"] 
