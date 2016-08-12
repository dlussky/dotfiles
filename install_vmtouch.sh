#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#installing vmtouch from git
git clone https://github.com/hoytech/vmtouch.git /tmp/buildvmtouch
cd /tmp/buildvmtouch
make
sudo make install
cd -
rm -rf /tmp/buildvmtouch
