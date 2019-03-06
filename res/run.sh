#!/bin/bash

if [ ! -d /var/www/html/typo3conf/ext/visit_tablets/.git ]
then
    git clone https://github.com/ViSIT-Dev/appbundle.git /var/www/html/typo3conf/ext/visit_tablets;
fi

chown www-data:www-data /var/www/html/typo3conf -hR
chown mysql:mysql /var/lib/mysql/typo3 -hR

/etc/init.d/mysql start > /dev/null
touch /var/log/mysql/error.log /var/log/apache2/error.log
/etc/init.d/apache2 start > /dev/null
wget -qO- http://localhost/typo3/ &> /dev/null 

tail -f /var/log/mysql/error.log /var/log/apache2/error.log
