FROM martinhelmich/typo3:8
LABEL maintainer="Kris Raich"

#import files
COPY res/run.sh /root/run.sh
COPY res/db.sql /tmp/db.sql
COPY --chown=www-data:www-data res/LocalConfiguration.php /var/www/html/typo3conf/LocalConfiguration.php

RUN	apt-get update && \
	apt-get install -y  git wget nano && \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get install -y mysql-server && \
	/etc/init.d/mysql start && \
	mysql -u root < /tmp/db.sql && \
	rm -f /tmp/db.sql && \
	apt-get clean

VOLUME ["/var/www/html/typo3conf/ext/visit_tablets"]

CMD	bash /root/run.sh