#!/bin/bash
set -euox pipefail
IFS=$'\n\t'

DOCKER_COMPOSE_RELEASE_ARCH="Linux-x86_64"
DOCKER_COMPOSE_INSTALL_PATH="/usr/bin/docker-compose"

#качаем свежий docker-compose, парся ссылку из данных о последнем релизе на гитхабе
curl -s "https://api.github.com/repos/docker/compose/releases/latest" \
  | grep "browser_download_url" \
  | grep $DOCKER_COMPOSE_RELEASE_ARCH \
  | grep -v "sha256" \
  | cut -d '"' -f 4 \
  | sudo wget -O $DOCKER_COMPOSE_INSTALL_PATH  -qi -

sudo chmod +x $DOCKER_COMPOSE_INSTALL_PATH

echo "Latest docker-compose installed successfully"