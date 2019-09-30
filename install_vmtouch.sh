#!/bin/bash
set -euox pipefail
IFS=$'\n\t'

BUILD_DIR=/tmp/buildvmtouch

git clone https://github.com/hoytech/vmtouch.git $BUILD_DIR
cd $BUILD_DIR

make
sudo make install

cd -

rm -rf $BUILD_DIR
