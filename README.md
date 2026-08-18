# NetflixClone-Pipeline

-Create a vm (large) with 30+ gb of memory

-Install jenkins official docs step by step

-Install docker from official docs step by step

-add jenkins user to docker group and refresh with newgrp docker

-Install sonarqube (if you want to run sonarkube in docker):
docker run -d \
 --name sonarqube \
 -p 9000:9000 \
 sonarqube:lts-community
