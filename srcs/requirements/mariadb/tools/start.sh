#!/bin/sh

if [ ! -d "/var/lib/mysql/$MARIADB_NAME" ]; then

service mariadb start

sleep 1

mysql_secure_installation << STOP

Y
$MARIADB_ROOT_PASS
$MARIADB_ROOT_PASS
Y
Y
Y
Y
STOP

	sleep 1
	mysql -u root -e "CREATE DATABASE $MARIADB_NAME;"
	mysql -u root -e "CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PASS';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$MARIADB_USER'@'%';"
	mysql -u root -e "FLUSH PRIVILEGES;"

	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASS';"
	mysql -u root -p$MARIADB_ROOT_PASS -e "FLUSH PRIVILEGES;"
	mysqladmin -u root -p$MARIADB_ROOT_PASS shutdown

else
	echo "Database already exists"
	sleep 1
fi

exec "$@"
