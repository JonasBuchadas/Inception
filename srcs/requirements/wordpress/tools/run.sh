#!/bin/sh

cd /var/www/html

# wordpress_user_name=$(echo ${CREDENTIALS} | jq .wordpress_user.name)
# wordpress_user_email=$(echo ${CREDENTIALS} | jq .wordpress_user.email)
# wordpress_user_pass=$(echo ${CREDENTIALS} | jq .wordpress_user.pass)
# wordpress_admin_name=$(echo ${CREDENTIALS} | jq .wordpress_admin.name)
# wordpress_admin_email=$(echo ${CREDENTIALS} | jq .wordpress_admin.email)
# wordpress_admin_pass=$(echo ${CREDENTIALS} | jq .wordpress_admin.pass)

if [ ! -f "/var/www/html/wp-config.php" ]; then
	wp cli update --yes --allow-root
	wp core download --allow-root
	wp config create --dbname=${MARIADB_NAME} --dbuser=${MARIADB_USER} --dbpass=${MARIADB_USER_PASS} --dbhost=${MARIADB_HOST} --allow-root --path=/var/www/html
	wp core install --url=${DOMAIN} --title=${WORDPRESS_TITLE} --admin_user=$WORDPRESS_ADMIN_NAME --admin_password=$WORDPRESS_ADMIN_PASS --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root
	wp user create "${WORDPRESS_USER_NAME}" "${WORDPRESS_USER_EMAIL}" --role=author --user_pass=$WORDPRESS_USER_PASS --display_name="${MARIADB_USER}" --path=${WORDPRESS_PATH} --allow-root
	wp theme install bravada --activate --allow-root
else
	echo "Wordpress already installed"
fi
echo "Starting WordPress fastCGI on port 9000."

exec /usr/sbin/php-fpm7.4 -F -R
