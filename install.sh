#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

./link_configs.sh

sudo add-apt-repository -y ppa:numix/ppa

sudo apt update
sudo apt upgrade -y
xargs -a misc/packages.list sudo apt install -yV
xargs -a misc/unwanted-packages.list sudo apt purge -yV

./install_albert.sh
./install_oh_my_zsh.sh
./install_motd_rocket.sh
./install_vmtouch.sh
./install_bat.sh

# creates additional symlink for icons
ln -s ~/.local/share/icons/flags ~/.icons/flags
# applies flag icons from freeflagicons.com
dconf write /org/mate/desktop/peripherals/keyboard/indicator/show-flags "true"
# sets awesome as preferred window manager
dconf write /org/mate/desktop/session/required-components/windowmanager "'awesome'"
# applies performance cpu governer
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
sudo systemctl stop ondemand
sudo systemctl disable ondemand
sudo systemctl mask ondemand

# bbr congestion control
printf "net.core.default_qdisc=fq \nnet.ipv4.tcp_congestion_control=bbr" | sudo tee /etc/sysctl.d/42-congestion.conf
# inotify watch limit
echo 'fs.inotify.max_user_watches=524288' | sudo tee /etc/sysctl.d/42-inotify-watch-limit.conf
# applies sysctl config
sudo sysctl -p
#awesomewm cursor fix
xsetroot -cursor_name left_ptr
#firefox libinput scrolling fix
echo "MOZ_USE_XINPUT2=1" | sudo tee -a /etc/environment.d/10-firefox-libintput-fix.conf
