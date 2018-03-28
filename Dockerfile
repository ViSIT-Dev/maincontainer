FROM martinhelmich/typo3
LABEL maintainer="Kris Raich <krispin.raich@fh-kufstein.ac.at>"

#import files
COPY res/run.sh /root/run.sh
COPY res/db.sql /tmp/db.sql
COPY res/LocalConfiguration.php /var/www/html/typo3conf/LocalConfiguration.php


RUN echo "----- start -----"   
RUN		apt-get update 
RUN	echo "----- install utils -----" 
RUN		apt-get install -y  git wget nano 
RUN	echo "----- install mysql -----" 
RUN		export DEBIAN_FRONTEND=noninteractive 
RUN		apt-get install -y mysql-server 
RUN	echo "----- add typo3 user and prepare db -----"  
RUN		/etc/init.d/mysql start && mysql -u root < /tmp/db.sql  
RUN		chown www-data:www-data /var/www/html/typo3conf/LocalConfiguration.php
RUN	echo "----- cleanup -----"  
RUN		rm -f /tmp/db.sql 
RUN 	apt-get clean
RUN	echo "done" 

CMD bash /root/run.sh