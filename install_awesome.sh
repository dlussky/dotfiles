#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


#https://packages.ubuntu.com/zesty/amd64/libxcb-xrm0/download
#https://packages.ubuntu.com/zesty/amd64/libxcb-xrm-dev/download
#installing awesome from git
AWESOME_VERSION="v4.2"
sudo apt-get install cmake lua5.2 glib-2.0 libcairo2-dev libx11-dev libxcb-* libgdk-pixbuf2.0-dev libx11-xcb-dev libxkbcommon-dev libxkbcommon-x11-dev libstartup-notification0-dev libxdg-basedir-dev liblua5.2* libdbus-1-dev lua-lgi-dev imagemagick
git clone https://github.com/awesomeWM/awesome.git
cd awesome
git checkout $AWESOME_VERSION
make
sudo make install
cd ..
rm -rf awesome
