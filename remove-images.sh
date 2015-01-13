#!/bin/bash
# Delete all containers
#sudo docker rm $(sudo docker ps -a -q)
sudo docker rmi $(sudo docker images -q)
