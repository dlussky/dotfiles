#!/bin/bash
set -euox pipefail
IFS=$'\n\t'

#Для 18.04 bionic, для 16.04 xenial
UBUNTU_CODENAME="bionic"
DOCKER_REPO_KEY_URL="https://download.docker.com/linux/ubuntu/gpg"
DOCKER_REPO_STRING="deb [arch=amd64] https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable"
DOCKER_APT_LIST_FILENAME="/etc/apt/sources.list.d/docker-repository-$UBUNTU_CODENAME.list"


#нужно для работы с репозиториями по https
sudo apt install -yV apt-transport-https gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

if [ ! -f $DOCKER_APT_LIST_FILENAME ] ; then
    echo $DOCKER_REPO_STRING | sudo tee $DOCKER_APT_LIST_FILENAME
    apt update
fi

sudo apt install -yV docker-ce

#добавляем себя в группу docker, чтобы работать без sudo (заработает после перезагрузки)
sudo usermod -aG docker $USER

echo "Latest docker was installed successfully"