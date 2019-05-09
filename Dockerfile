FROM martinhelmich/typo3:8
LABEL maintainer="Kris Raich"

#import files
COPY res/run.sh /root/run.sh
COPY res/db.sql /tmp/db.sql
COPY res/cronjob /etc/cron.d/typo3cron
COPY --chown=www-data:www-data res/LocalConfiguration.php /var/www/html/typo3conf/LocalConfiguration.php
COPY --chown=www-data:www-data res/PackageStates.php /var/www/html/typo3conf/PackageStates.php

RUN echo "deb http://apt.syncthing.net/ syncthing stable" | tee /etc/apt/sources.list.d/syncthing.list
RUN export DEBIAN_FRONTEND=noninteractive
RUN mkdir -p /var/www/private /usr/share/man/man1
RUN apt-get update && apt-get install -y  --allow-unauthenticated git wget nano mysql-server syncthing default-jre
RUN apt-get -y install cron && chmod 0644 /etc/cron.d/typo3cron && crontab /etc/cron.d/typo3cron
RUN /etc/init.d/mysql start && mysql -uroot < /tmp/db.sql
RUN /etc/init.d/cron start
RUN apt-get clean
RUN rm -f /tmp/db.sql
RUN wget -q https://github.com/ViSIT-Dev/syncthing-control/raw/master/dist/Syncthing_Control.jar -P /var/www/
RUN chmod 755 /var/www/Syncthing_Control.jar
RUN echo "php_value upload_max_filesize 500M" >> /var/www/html/.htaccess
RUN echo "php_value post_max_size 500M" >> /var/www/html/.htaccess

VOLUME ["/var/www/html/typo3conf/ext/visit_tablets", "/var/lib/mysql", "/var/www/html/fileadmin", "/var/www/syncthing", "/var/www/sync", "/var/www/private"]

#syncthing
EXPOSE 8384 22000 21027/udp

CMD	bash /root/run.sh