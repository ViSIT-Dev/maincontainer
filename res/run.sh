#!/bin/bash

if [[ ! -d /var/www/html/typo3conf/ext/visit_tablets/.git ]]
then
    git clone https://github.com/ViSIT-Dev/appbundle.git /var/www/html/typo3conf/ext/visit_tablets;
fi

chown www-data:www-data /var/www/html/typo3conf -hR

/etc/init.d/mysql start > /dev/null
touch /var/log/mysql/error.log /var/log/apache2/error.log
/etc/init.d/apache2 start > /dev/null
wget -qO- http://localhost/typo3/ &> /dev/null 

env HOME=/var/syncthing
nohup /usr/bin/syncthing -home /var/syncthing/config -gui-address 0.0.0.0:8384 &>/var/log/syncthing.log &

tail -f /var/log/mysql/error.log /var/log/apache2/error.log /var/log/syncthing.log
