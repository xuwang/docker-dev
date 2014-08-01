#!/bin/bash

export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_RUN_DIRP=/var/run/apache2
export APACHE_LOG_DIR=/var/log/apache2
export APACHE_LOCK_DIR=/var/lock/apache2
export APACHE_PID_FILE=/var/run/apache2.pid

#Config for phpMyAdmin
if [ -f /config/config.inc.php ]; then
    cp -f /config/config.inc.php /etc/phpmyadmin/config.inc.php
fi

#phpMyAdmin setup htpasswd
if [ -f /config/htpasswd.setup ]; then
    if [ ! -d /usr/share/phpmyadmin/config ]; then
        sudo mkdir /usr/share/phpmyadmin/config
        sudo chmod o+x /usr/share/phpmyadmin/config
    fi
    cp -f /config/htpasswd.setup /etc/phpmyadmin/htpasswd.setup
fi

#Config for Apache2
if [ -f /config/apache-000-default.conf ]; then
    cp -f /config/apache-000-default.conf /etc/apache2/sites-enabled/000-default.conf
fi

#apache2ctl start   # well, not working
/usr/sbin/apache2 -D FOREGROUND

