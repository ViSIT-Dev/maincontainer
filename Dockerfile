FROM martinhelmich/typo3:8
LABEL maintainer="Kris Raich"

#import files
COPY res/run.sh /root/run.sh
COPY res/db.sql /tmp/db.sql
COPY --chown=www-data:www-data res/LocalConfiguration.php /var/www/html/typo3conf/LocalConfiguration.php
COPY --chown=www-data:www-data res/PackageStates.php /var/www/html/typo3conf/PackageStates.php

RUN echo "deb http://apt.syncthing.net/ syncthing stable" | tee /etc/apt/sources.list.d/syncthing.list && \
    export DEBIAN_FRONTEND=noninteractive && \
    mkdir -p /usr/share/man/man1 && \
    apt-get update && apt-get install -y  --allow-unauthenticated git wget nano mysql-server syncthing default-jre && \
    /etc/init.d/mysql start && \
	mysql -u root < /tmp/db.sql && \
	rm -f /tmp/db.sql && \
	apt-get clean && \
	wget https://github.com/ViSIT-Dev/syncthing-control/raw/master/dist/Syncthing_Control.jar -P /var/www/ && chown www-data:www-data /var/www/Syncthing_Control.jar && \
	echo "php_value upload_max_filesize 500M" >> /var/www/html/.htaccess && \
	echo "php_value post_max_size 500M" >> /var/www/html/.htaccess

VOLUME ["/var/www/html/typo3conf/ext/visit_tablets", "/var/lib/mysql", "/var/syncthing", "/var/p2p"]

#syncthing
EXPOSE 8384 22000 21027/udp

CMD	bash /root/run.sh