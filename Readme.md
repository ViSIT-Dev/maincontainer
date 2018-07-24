Sponsored by Interreg Bayern/Österreich im Zuge des ViSIT Projektes
(c) FH Kufstein Tirol

# App Container für ViSIT

[![Docker build status](https://img.shields.io/docker/build/visitapp/maincontainer.svg)](https://hub.docker.com/r/visitapp/maincontainer/)

Beinhaltet kompletten LAMP-Stack und Typo3

## Typo3 Login
    Benutzer: admin
    Passwort: visit-admin
Passwort nach dem ersten Login ändern!

## Kommandos
* docker run --name visit-main -p 80:80 visitapp/maincontainer
* docker run --name visit-main -p 8080:80 -v S:\web\visitapp\ext:/var/www/html/typo3conf/ext  visitapp/maincontainer
* docker exec -it visit-main /bin/bash
* docker stop visit-main
* docker build  -t "visitapp/maincontainer" .
* docker rmi visitapp/maincontainer
