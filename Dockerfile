FROM martinhelmich/typo3
LABEL maintainer="Kris Raich <krispin.raich@gh-kufstein.ac.at>"


RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \

	#install utils and mysql
	apt-get install -y git wget nano && \
	apt-get install -y git mysql-server && \
	/etc/init.d/mysql restart && \
	
	#add typo3 user
	mysql -e "CREATE DATABASE typo3;" && \
    mysql -e "CREATE USER typo3@localhost IDENTIFIED BY 'typo3';" && \
    mysql -e "GRANT ALL PRIVILEGES ON typo3.* TO 'typo3'@'localhost';" && \
    mysql -e "FLUSH PRIVILEGES;"
	
#install typo3
COPY LocalConfiguration.php /var/www/html/typo3conf/LocalConfiguration.php
	
#docker run --name visit-main --rm  -p 80:80 ruhmesmeile/php-nginx-typo3
#docker exec -it visit-main /bin/bash