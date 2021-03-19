#!/bin/bash
set -xeuo pipefail
IFS=$'\n\t'

#Big thanks to Elana Hashman: https://hashman.ca/zoom/

if [ -z "${1-}" ]; then
    echo "Patches Zoom .deb package to remove ibus dependency and installs it."
    echo "Usage: install_zoom.sh zoom_package.deb"
    exit 1
fi


DEB_FILE=$1
DEB_FILE_PATCHED=zoom_no_ibus.deb
SCRATCH_DIR=$(mktemp -d)

# Extract package contents
dpkg -x $DEB_FILE $SCRATCH_DIR

# Extract package control information
dpkg -e $DEB_FILE $SCRATCH_DIR/DEBIAN

# Remove the ibus dependency
sed -i -E 's/(ibus, |, ibus)//' $SCRATCH_DIR/DEBIAN/control

# Rebuild the .deb
dpkg -b $SCRATCH_DIR $DEB_FILE_PATCHED

sudo apt install -y libegl1-mesa
sudo dpkg -i $DEB_FILE_PATCHED

rm -f $DEB_FILE_PATCHED
rm -rf $SCRATCH_DIR
