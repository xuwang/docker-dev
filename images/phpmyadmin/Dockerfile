FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections && \
	apt-get install -y apache2 php5 libapache2-mod-php5 php5-mcrypt phpmyadmin

RUN mkdir /usr/share/phpmyadmin/config && \
	chmod o+x /usr/share/phpmyadmin/config

#Config for phpMyAdmin, can be overwrite in run.sh
ADD config/config.inc.php /etc/phpmyadmin/config.inc.php

#phpMyAdmin setup htpasswd, can be overwrite in run.sh
ADD config/htpasswd.setup /etc/phpmyadmin/htpasswd.setup

#Config for Apache2, can be overwrite in run.sh
ADD config/apache-000-default.conf /etc/apache2/sites-enabled/000-default.conf

ADD run.sh /run.sh

EXPOSE 80

CMD ["/run.sh"]