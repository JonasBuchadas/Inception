FROM debian:oldstable

RUN apt update -y && apt upgrade -y && apt-get install -y mariadb-server

COPY ./conf/50-server.conf /etc/mysql/mariadb.conf.d/

COPY ./tools/start.sh /

RUN chmod +x /start.sh

RUN mysql_install_db

EXPOSE 3306

ENTRYPOINT [ "./start.sh" ]

CMD ["mysqld_safe", "--bind-address=0.0.0.0"]

