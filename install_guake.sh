#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#install latest guake
GUAKE_VERSION="0.8.5"
sudo apt-get build-dep -y guake
git clone https://github.com/Guake/guake.git
cd guake
git checkout $GUAKE_VERSION
./autogen.sh 
./configure 
make
sudo make install
cd ..
rm -rf guake