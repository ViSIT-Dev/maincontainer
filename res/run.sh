#!/bin/bash
/etc/init.d/apache2 start > /dev/null
/etc/init.d/mysql start > /dev/null
touch /var/log/mysql/error.log /var/log/apache2/error.log
tail -f /var/log/mysql/error.log /var/log/apache2/error.log