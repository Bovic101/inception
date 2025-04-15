FROM alpine:3.16

# Arguments for database credentials
ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG DB_ROOT

# Install MariaDB and MariaDB client
RUN apk update && apk add --no-cache mariadb mariadb-client

# Configure MariaDB
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf

# Initialize the database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Expose MariaDB port
EXPOSE 3306

# Copy database initialization script and run it
COPY requirements/mariadb/conf/create_db.sh .
RUN sh create_db.sh && rm create_db.sh

# Switch to mysql user for the final command
USER mysql

# Command to start MariaDB
CMD ["/usr/bin/mysqld", "--skip-log-error"]
