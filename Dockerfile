FROM martinhelmich/typo3
LABEL maintainer="Kris Raich <krispin.raich@fh-kufstein.ac.at>"

#import db dump
COPY db.sql /tmp/db.sql
COPY LocalConfiguration.php /var/www/html/typo3conf/LocalConfiguration.php

RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \

	#install utils
	apt-get install -y wget git nano && \
	
	#install mysql
	apt-get install -y mysql-server && \
	/etc/init.d/mysql start && \
	
	#add typo3 user and prepare db
	mysql -u root < /tmp/db.sql  && \
	/etc/init.d/mysql start && \
	
	#cleanup
	wget -qO- http://localhost/typo3/ &> /dev/null && \
	rm -f /tmp/db.sql  /var/www/html/FIRST_INSTALL && \
	chown www-data:www-data  /var/www/html/typo3conf/LocalConfiguration.php
	

#CMD tail -f /var/log/mysql/error.log
