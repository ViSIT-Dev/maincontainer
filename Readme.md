# App Container für ViSIT

[![Docker build status](https://img.shields.io/docker/build/visitapp/maincontainer.svg)](https://hub.docker.com/r/visitapp/maincontainer/)

Beinhaltet kompletten LAMP-Stack und Typo3

## Typo3 Login
    Benutzer: admin
    Passwort: visit-admin
Passwort nach dem ersten Login ändern!

## Kommandos
* docker run --name visit-main -p 80:80 visitapp/maincontainer
* docker exec -it visit-main /bin/bash
* docker stop visit-main
* docker build  -t "visitapp/maincontainer" .
* docker rmi visitapp/maincontainer