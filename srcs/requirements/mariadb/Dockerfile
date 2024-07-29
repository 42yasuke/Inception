# Start from a debian image base
FROM debian:bullseye

# Update and Install packages
RUN apt-get update -y
RUN apt-get install -y mariadb-server mariadb-client

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb.sh /etc/mysql/mariadb.conf.d/mariadb.sh

RUN chmod +x /etc/mysql/mariadb.conf.d/mariadb.sh

# Expose port 3306 for mariadb
EXPOSE 3306

# Start the MariaDB server
CMD ["./etc/mysql/mariadb.conf.d/mariadb.sh"]