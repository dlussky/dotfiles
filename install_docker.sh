#!/bin/bash
set -euox pipefail
IFS=$'\n\t'

UBUNTU_CODENAME=bionic
DOCKER_REPO_KEY_URL="https://download.docker.com/linux/ubuntu/gpg"
DOCKER_REPO_STRING="deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
DOCKER_APT_LIST_FILENAME="/etc/apt/sources.list.d/docker-repository-bionic.list"
DC_INSTALL_PATH=/usr/bin/docker-compose

sudo apt install -yV apt-transport-https gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

if [ ! -f $DOCKER_APT_LIST_FILENAME ] ; then
    echo $DOCKER_REPO_STRING | sudo tee $DOCKER_APT_LIST_FILENAME
    apt update
fi

sudo apt install -yV docker-ce

curl -s https://api.github.com/repos/docker/compose/releases/latest \
  | grep browser_download_url \
  | grep "Linux-x86_64" \
  | grep -v "sha256" \
  | cut -d '"' -f 4 \
  | sudo wget -O $DC_INSTALL_PATH  -qi -

sudo chmod +x $DC_INSTALL_PATH

sudo usermod -aG docker $USER
