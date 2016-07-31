#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#installing awesome from git
AWESOME_VERSION="v3.5.9"
sudo apt-get install cmake lua5.2 glib-2.0 libcairo2-dev libx11-dev libxcb-* libgdk-pixbuf2.0-dev libx11-xcb-dev libxkbcommon-dev libxkbcommon-x11-dev libstartup-notification0-dev libxdg-basedir-dev liblua* libdbus-1-dev lua-lgi-dev 
git clone https://github.com/awesomeWM/awesome.git
cd awesome
git checkout $AWESOME_VERSION
make
sudo make install
cd ..
rm -rf awesome