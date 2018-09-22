#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:webupd8team/terminix

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -yV install 													 \
	adb albert autossh build-essential checkinstall chromium-browser compton \
	doublecmd-gtk fastboot ffmpeg filezilla gparted htop iotop keepass2 	 \
	mc moc numix-icon-theme openssh-server php-cli qbittorrent redshift-gtk  \
	screenfetch sublime-text tilix tmux tree zsh awesome

./link_configs.sh

./install_albert.sh
./install_oh_my_zsh.sh
./install_motd_rocket.sh
./install_vmtouch.sh

# creates additional symlink for icons
ln -s ~/.local/share/icons/flags ~/.icons/flags
# applies flag icons from freeflagicons.com
dconf write /org/mate/desktop/peripherals/keyboard/indicator/show-flags "true"
