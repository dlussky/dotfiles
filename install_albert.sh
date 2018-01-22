#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#installing albert from git
ALBERT_VERSION="v0.14.14"

CURRENT_DIR=`pwd`
SRC_DIR=/tmp/albert_src
BUILD_DIR=/tmp/albert_build

sudo apt-get install -y g++ cmake qtbase5-dev libqt5x11extras5-dev libqt5svg5-dev libmuparser-dev qtdeclarative5-dev python3-dev 

git clone --recursive https://github.com/ManuelSchneid3r/albert.git $SRC_DIR
cd $SRC_DIR
git checkout $ALBERT_VERSION

#removing virtualbox plugin
cd plugins
rm -rf virtualbox

patch -b <<EOF

diff --git a/CMakeLists.txt b/CMakeLists.txt
index ce5090d..ef4716b 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -96,11 +96,6 @@ if (BUILD_TERMINAL)
     add_subdirectory(terminal)
 endif()
 
-option(BUILD_VIRTUALBOX "Build the extension" ON)
-if (BUILD_VIRTUALBOX)
-    add_subdirectory(virtualbox)
-endif()
-
 option(BUILD_WEBSEARCH "Build the extension" ON)
 if (BUILD_WEBSEARCH)
     add_subdirectory(websearch)

EOF

mkdir $BUILD_DIR
cd $BUILD_DIR

cmake $SRC_DIR -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
make
sudo make install

cd $CURRENT_DIR
rm -rf $SRC_DIR
rm -rf $BUILD_DIR
