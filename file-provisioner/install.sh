#!/bin/sh
sudo apt update -y
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt install docker.io -y
sudo groupadd docker
sudo usermod -aG docker $USER
sudo docker pull jenkins/jenkins
sudo docker ps
sudo docker run -p 8080:8080 --name=jenkins -dt jenkins/jenkins
sudo docker logs jenkins --details
