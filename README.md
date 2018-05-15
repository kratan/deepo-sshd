# Deepo with jupyter and ssh server

Basically it's just a mixture of work based on:
* https://github.com/maltyxx/docker-sshd
* https://github.com/ufoym/deepo

# Requirements:
* generate ssl keys for jupyter under ./volumes/certs/: openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout server.key -out server.crt
* place a public ssh key unter ./volumes/certs/id_pub.rsa or change your docker-compose.yaml file to fit
* edit docker-compose.yaml file to fit your username + uid + guids + folders + nvidia GPU confs



