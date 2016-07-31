#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

cd ~
wget -c http://download.microsoft.com/download/f/5/a/f5a3df76-d856-4a61-a6bd-722f52a5be26/PowerPointViewer.exe
mkdir ~/.cnsls
mv PowerPointViewer.exe ~/.cnsls/
cd ~/.cnsls/
cabextract PowerPointViewer.exe
cabextract ppviewer.cab
mkdir ~/.fonts
find -iname '*ttf' -exec cp {} ~/.fonts/ \;
fc-cache -fv ~/.fonts
rm -rf ~/.cnsls
