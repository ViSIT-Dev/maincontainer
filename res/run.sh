#!/bin/bash
/etc/init.d/apache2 start > /dev/null
/etc/init.d/mysql start > /dev/null
touch /var/log/mysql/error.log /var/log/apache2/error.log
wget -qO- http://localhost/typo3/ &> /dev/null 
tail -f /var/log/mysql/error.log /var/log/apache2/error.log