#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#installing albert from git
ALBERT_VERSION="v0.8.10"
sudo apt-get install -y g++ cmake qtbase5-dev libqt5x11extras5-dev libqt5svg5-dev libmuparser-dev
git clone https://github.com/ManuelSchneid3r/albert.git /tmp/buildalbert
cd /tmp/buildalbert
git checkout $ALBERT_VERSION
cmake . -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
make
sudo make install
cd -
rm -rf /tmp/buildalbert
