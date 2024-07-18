#!/bin/sh

# Check if wordpress is already downloaded
if [ -f /wordpress_installed ]
then
	echo "wordpress already installed"
	sleep 10
else
	echo "Configuring wordpress ..."

	# Wait for the database to be created correctly
	sleep 30

	# Setup the wp-config.php file
	sed -i "s/username_here/$MYSQL_USER/g" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOST/g" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" /var/www/html/wordpress/wp-config-sample.php
	mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

	# Fill wordpress first page
	wp core install --allow-root \
					--url=${DOMAIN_NAME} \
					--title=${WP_TITLE} \
					--admin_user=${WP_ADMIN_LOGIN} \
					--admin_password=${WP_ADMIN_PASSWORD} \
					--admin_email=${WP_ADMIN_EMAIL} \
					--path=${WP_PATH};

	# Add user1
	wp user create --allow-root \
					${WP_USER1_LOGIN} \
					${WP_USER1_EMAIL} \
					--user_pass=${WP_USER1_PASSWORD} \
					--path=${WP_PATH};

	touch /wordpress_installed
fi

echo "wordpress ready"
/usr/sbin/php-fpm7.3 -F