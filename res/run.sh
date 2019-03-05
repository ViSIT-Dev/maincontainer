#!/bin/bash

if [ ! -d /var/www/html/typo3conf/ext/visit_tablets ]
then
    git clone https://github.com/ViSIT-Dev/appbundle.git /var/www/html/typo3conf/ext/visit_tablets;
    chown www-data:www-data /var/www/html -hR && \
fi


/etc/init.d/apache2 start > /dev/null
/etc/init.d/mysql start > /dev/null
touch /var/log/mysql/error.log /var/log/apache2/error.log
wget -qO- http://localhost/typo3/ &> /dev/null 
tail -f /var/log/mysql/error.log /var/log/apache2/error.log
