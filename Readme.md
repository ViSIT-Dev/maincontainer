



typo3 credentials 
admin / visit-admin


	
docker build  -t "visitapp/maincontainer" .
docker run --name visit-main --rm -p 80:80 visitapp/maincontainer
docker exec -it visit-main /bin/bash
docker stop visit-main
docker rmi visitapp/maincontainer

#code
mysqldump -u root typo3 > ../dump.html