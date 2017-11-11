#!/bin/sh
/bin/sed -i '/define(.DB_TYPE.,/s/,.*$/, "'$DB_TYPE'");/' /var/www/config.php
/bin/sed -i '/define(.DB_HOST.,/s/,.*$/, "'$DB_HOST'");/' /var/www/config.php
/bin/sed -i '/define(.DB_USER.,/s/,.*$/, "'$DB_USER'");/' /var/www/config.php
/bin/sed -i '/define(.DB_NAME.,/s/,.*$/, "'$DB_NAME'");/' /var/www/config.php
/bin/sed -i '/define(.DB_PASS.,/s/,.*$/, "'$DB_PASS'");/' /var/www/config.php
/bin/sed -i '/define(.DB_PORT.,/s/,.*$/, "'$DB_PORT'");/' /var/www/config.php
/bin/sed -i '/define(.SELF_URL_PATH.,/s/,.*$/, "'$SELF_URL_PATH'");/' /var/www/config.php
/usr/bin/php5 /var/www/configure-db.php
/usr/bin/php-fpm5
chown -R nobody:nobody /var/www/lock
/bin/su nobody -s '/var/www/update_daemon2.php' > /dev/stdout 2>&1 &
/usr/sbin/nginx
