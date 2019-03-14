Sponsored by Interreg Bayern/Österreich im Zuge des ViSIT Projektes(c) FH Kufstein Tirol# App Container für ViSIT[![Docker build status](https://img.shields.io/docker/build/visitapp/maincontainer.svg)](https://hub.docker.com/r/visitapp/maincontainer/)Beinhaltet kompletten LAMP-Stack und Typo3## Typo3 Login    Benutzer: admin    Passwort: visit-adminPasswort nach dem ersten Login ändern!## Docker Kommandos Getestet mit Docker 2.0### Test Betrieb* docker volume create visit-database* docker volume create visit-syncthing* docker run -d --name visit-dev -p 8080:80 -p 8384:8384 -p 22000:22000 -p 21027:21027 -v visit-syncthing:/var/syncthing -v s:/p2p/visit:/var/p2p -v s:/web/appbundle:/var/www/html/typo3conf/ext/visit_tablets -v visit-database:/var/lib/mysql visitapp/maincontainer* docker stop visit-dev && docker rm visit-dev### Produktiv Betrieb * docker volume create visit-database* docker volume create visit-syncthing* docker run -d --name visit -p 80:80 -p 22000:22000 -p 21027:21027 -v visit-syncthing:/var/syncthing -v s:/p2p/visit:/var/p2p -v visit-database:/var/lib/mysql --restart unless-stopped visitapp/maincontainer### Debug* docker exec -it visit-dev /bin/bash* docker logs visit-dev### Builden* docker build  -t "visitapp/maincontainer" .* docker rmi visitapp/maincontainer* docker image prune## Container für Offline Anwendung vorbereiten (Windows zu Windows)### Möglichkeit 11. Den Container Initialisieren2. Die Applikationen installieren und Inhalte einpflegen3. Docker Stoppen4. Docker Image aus Container erstellen (docker commit visit-main visit-offline-image)5. Docker Image in TAR Archiv packen (docker save -o c:\path\to\archive.tar visit-offline-image)6. TAR Archiv UND App-Dateien auf Offline-PC Übertragen (Der Offline PC muss Docker Installiert haben)7. Docker Image über TAR Archiv importieren (docker load -i c:\path\to\archive.tar)8. Docker Image Starten (docker run -d --name visit-main -p 8080:80 -v s:/web/visitapp/ext:/var/www/html/typo3conf/ext visit-offline-image)### Möglichkeit 21. Typo3 am Offline PC Installieren2. Visit-Extension installieren3. Inhalte direkt am Offline PC erstellen