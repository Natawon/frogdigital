#!/bin/bash
# docker stop $(docker ps -a -q)
# docker rm $(docker ps -a -q)

# docker stop pat
# docker rm pat
# docker rmi pat
# docker build -t frogdigital/ubuntu:platform-$1 .
docker build --platform=linux/amd64 -t frogdigital/ubuntu:nginx-php7.1-$1 .
docker tag frogdigital/ubuntu:nginx-php7.1-$1 frogdigital/ubuntu:nginx-php7.1-$1
sleep 5

docker push frogdigital/ubuntu:nginx-php7.1-$1
# docker run --name pat -v $PWD/apps:/var/www/html -p 80:80 -h lemp -d pat:latest
# docker exec -ti pat bash

