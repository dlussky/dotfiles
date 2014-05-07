#first-things-to-do-after-install script (tested on ubuntu 12.10)
#repos
sudo add-apt-repository -y ppa:alexx2000/doublecmd-svn
sudo add-apt-repository -y ppa:webupd8team/sublime-text-2
sudo add-apt-repository -y ppa:no1wantdthisname/ppa
sudo add-apt-repository -y ppa:no1wantdthisname/openjdk-fontfix
sudo add-apt-repository -y ppa:klaus-vormweg/awesome
sudo add-apt-repository -y ppa:richardgv/compton 


sudo sh -c 'echo "deb http://repo.ajenti.org/debian main main" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list.d/opera.list' 

wget http://repo.ajenti.org/debian/key -O- | sudo apt-key add -
wget http://deb.opera.com/archive.key -O- | sudo apt-key add -

#software
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install compton notification-daemon ajenti openjdk-7-jdk fontconfig-infinality mc guake synapse php5 php5-cli php5-fpm php5-mysqlnd nginx-full opera doublecmd-gtk sublime-text filezilla awesome awesome-extra git cabextract moc zsh screen htop shutter
sudo apt-get -y remove appmenu-gtk appmenu-gtk3 appmenu-qt

#installing awesome-over-gnome
sudo sh -c '
printf "%s\n" "[Desktop Entry]" "Version=1.0" "Type=Application" "Name=awesome" "TryExec=awesome" "Exec=awesome" | tee /usr/share/applications/awesome.desktop && \
printf "%s\n" "[Desktop Entry]" "Name=Gnome with Awesome" "Comment=Gnome with Awesome as window manager" "TryExec=gnome-session" "Exec=gnome-session --session=awesome" "Type=Application" | tee /usr/share/xsessions/gnome-awesome.desktop && \
printf "%s\n" "[GNOME Session]" "Name=Awesome" "RequiredComponents=gnome-settings-daemon;" "RequiredProviders=windowmanager;" "DefaultProvider-windowmanager=awesome" | tee /usr/share/gnome-session/sessions/awesome.session'

#configs (assuming you cloned this repo to ~/dotfiles)
cp -R /etc/xdg/awesome ~/.config
mkdir ~/.config/awesome/themes
ln -s ~/dotfiles/aurantium.custom ~/.config/awesome/themes/aurantium.custom
rm ~/.config/awesome/rc.lua
ln -s ~/dotfiles/rc.lua ~/.config/awesome/rc.lua
ln -s ~/dotfiles/cal.lua ~/.config/awesome/cal.lua
ln -s ~/dotfiles/rc.lua ~/rc.lua

ln -s ~/dotfiles/kbtweaks.sh ~/kbtweaks.sh

sudo chown root:root ~/kbtweaks.sh
sudo chmod 744 ~/kbtweaks.sh
sudo sh -c 'echo "ALL	ALL=NOPASSWD: /home/dlussky/kbtweaks.sh" >> /etc/sudoers'

ln -s ~/dotfiles/.zshrc ~/.zshrc

sudo ln -s ~/dotfiles/run_once /bin/run_once

#windows fonts (including Consolas)
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


sudo sed -i "s/USE_STYLE=.*/USE_STYLE=\"SHARPENED\"/" /etc/profile.d/infinality-settings.sh
sudo /etc/fonts/infinality/infctl.sh setstyle linux

#xcompmgr


# nautilus --no-desktop !!!
#  /etc/xdg/autostart !!!
