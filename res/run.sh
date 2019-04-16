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

env HOME=/var/www/syncthing
su www-data -s /bin/bash -c "nohup /usr/bin/syncthing -home /var/www/syncthing -gui-address 0.0.0.0:8384 &>/var/www/syncthing.log &"

tail -f /var/log/mysql/error.log /var/log/apache2/error.log /var/www/syncthing.log
