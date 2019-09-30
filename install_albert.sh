#!/bin/bash
set -euox pipefail
IFS=$'\n\t'

ALBERT_VERSION="v0.16.1"

SRC_DIR=/tmp/albert_src
BUILD_DIR=/tmp/albert_build

NPROC=$(nproc)

sudo apt-get install -y g++ cmake qtbase5-dev libqt5x11extras5-dev libqt5svg5-dev libmuparser-dev qtdeclarative5-dev python3-dev libqt5charts5-dev libqt5sql5-sqlite

git clone --recursive https://github.com/ManuelSchneid3r/albert.git $SRC_DIR
git -C $SRC_DIR checkout $ALBERT_VERSION

mkdir $BUILD_DIR
cd $BUILD_DIR

cmake $SRC_DIR -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DBUILD_VIRTUALBOX=Off -DBUILD_QUALCULATE=Off
make -j $NPROC
sudo make install

cd -

rm -rf $SRC_DIR
rm -rf $BUILD_DIR
