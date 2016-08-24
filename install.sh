#!/bin/bash
set -euo pipefail
IFS=$'\n\t'





sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:george-edison55/cmake-3.x
sudo add-apt-repository -y ppa:alexx2000/doublecmd
sudo add-apt-repository -y ppa:flexiondotorg/albert 


sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -yV install redshift-gtk qbittorrent skype keepass2 virtualbox autossh compton mc guake albert php php-cli doublecmd-gtk sublime-text filezilla cabextract moc zsh tmux htop build-essential checkinstall openssh-server expect screenfetch numix-icon-theme

#freetype build-dep
#sudo apt-get -y install fontconfig fontconfig-config libcairo-gobject2 libcairo-gobject2:i386 libcairo-script-interpreter2 libcairo2 libcairo2:i386 libcairo2-dev libfontconfig1 libfontconfig1:i386 libfontconfig1-dev libfreetype6:i386 libfreetype6 libfreetype6-dev

#appies icons from freeflagicons.com
dconf write /org/mate/desktop/peripherals/keyboard/indicator/show-flags "true"

#infinality
#sudo add-apt-repository -y ppa:rjvbertin/infinaltimate #1
#sudo expect misc/fc-presets.expect #for rjvbertin
#sudo add-apt-repository -y ppa:no1wantdthisname/ppa    #2
