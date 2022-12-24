#!/bin/bash
IFS=$'\n\t'
set -xeuo pipefail

#Big thanks to Elana Hashman: https://hashman.ca/zoom/

SCRATCH_DIR=$(mktemp -d)
DEB_FILE=$SCRATCH_DIR/zoom_w_ibus.deb
DEB_FILE_PATCHED=$SCRATCH_DIR/zoom_no_ibus.deb

# Download latest zoom
wget -O $DEB_FILE https://zoom.us/client/latest/zoom_amd64.deb

# Extract package contents
dpkg -x $DEB_FILE $SCRATCH_DIR

# Extract package control information
dpkg -e $DEB_FILE $SCRATCH_DIR/DEBIAN

# Remove the ibus dependency
sed -i -E 's/(ibus, |, ibus)//' $SCRATCH_DIR/DEBIAN/control

# Rebuild the .deb
dpkg -b $SCRATCH_DIR $DEB_FILE_PATCHED

# Install libegl1-mesa if not installed
pkg=libegl1-mesa
status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
  sudo apt install -y $pkg
fi

sudo dpkg -i $DEB_FILE_PATCHED

rm -rf $SCRATCH_DIR
