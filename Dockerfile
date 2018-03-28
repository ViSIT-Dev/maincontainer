FROM martinhelmich/typo3
LABEL maintainer="Kris Raich <krispin.raich@fh-kufstein.ac.at>"

#import db dump
COPY res/db.sql /tmp/db.sql
COPY --chown=www-data:www-data res/LocalConfiguration.php /var/www/html/typo3conf/LocalConfiguration.php

RUN echo "start"  && \ 
		apt-get update && \
	echo "install utils" && \
		apt-get install -y wget git nano && \
	echo "install mysql" && \
		export DEBIAN_FRONTEND=noninteractive && \
		apt-get install -y mysql-server && \
		/etc/init.d/mysql start && \
	echo "add typo3 user and prepare db"  && \
		mysql -u root < /tmp/db.sql  && \
		/etc/init.d/mysql start && \
	echo "cleanup"  && \
		wget -qO- http://localhost/typo3/ &> /dev/null && \
		#rm -f /tmp/db.sql  /var/www/html/FIRST_INSTALL && \
	echo "done" 
	

#CMD tail -f /var/log/mysql/error.log
