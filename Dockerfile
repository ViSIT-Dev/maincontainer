FROM martinhelmich/typo3
LABEL maintainer="Kris Raich"

#import files
COPY res/run.sh /root/run.sh
COPY res/db.sql /tmp/db.sql
COPY res/LocalConfiguration.php /var/www/html/typo3conf/LocalConfiguration.php

RUN	apt-get update && \
	apt-get install -y  git wget nano && \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get install -y mysql-server && \
	/etc/init.d/mysql start && \
	mysql -u root < /tmp/db.sql && \
	chown -hR www-data:www-data /var/www/html && \
	rm -f /tmp/db.sql && \
	apt-get clean

VOLUME ["/var/www/html/typo3conf/ext"]

CMD	bash /root/run.sh

#export DB
#mysqldump -u root typo3 > export.html