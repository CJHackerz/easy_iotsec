#!/bin/bash
sudo apt-get update -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" >> /etc/apt/source.list.d/docker.list
sudo apt update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y