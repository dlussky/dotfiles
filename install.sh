#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

./link_configs.sh

sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:webupd8team/terminix

sudo apt update
sudo apt -y upgrade
xargs -a misc/packages.list sudo apt install -yV

./install_albert.sh
./install_oh_my_zsh.sh
./install_motd_rocket.sh
./install_vmtouch.sh

# creates additional symlink for icons
ln -s ~/.local/share/icons/flags ~/.icons/flags
# applies flag icons from freeflagicons.com
dconf write /org/mate/desktop/peripherals/keyboard/indicator/show-flags "true"
