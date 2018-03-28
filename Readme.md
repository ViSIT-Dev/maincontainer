# App Container für ViSIT

[![Docker build status](https://img.shields.io/docker/build/visitapp/maincontainer.svg)](https://hub.docker.com/r/visitapp/maincontainer/)

Basiert auf Container: martinhelmich/typo3

## Typo3 Login
    Benutzer: admin
    Passwort: visit-admin
Passwort und nach dem Login ändern!

## Kommandos
* docker build  -t "visitapp/maincontainer" .
* docker run --name visit-main --rm -p 80:80 visitapp/maincontainer
* docker exec -it visit-main /bin/bash
* docker stop visit-main
* docker rmi visitapp/maincontainer
