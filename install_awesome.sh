#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#installing awesome from git
AWESOME_VERSION="v4.2"

BUILD_DIR=/tmp/awesome

sudo apt-get install cmake lua5.2 glib-2.0 libcairo2-dev libx11-dev libxcb-* libgdk-pixbuf2.0-dev libx11-xcb-dev libxkbcommon-dev libxkbcommon-x11-dev libstartup-notification0-dev libxdg-basedir-dev liblua5.2* libdbus-1-dev lua-lgi-dev imagemagick

git clone https://github.com/awesomeWM/awesome.git $BUILD_DIR
cd $BUILD_DIR
git checkout $AWESOME_VERSION

make
make package

sudo dpkg -i build/awesome-*-Linux.deb

cd ..
rm -rf $BUILD_DIR
