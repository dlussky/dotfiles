sudo add-apt-repository -y ppa:alexx2000/doublecmd
sudo add-apt-repository -y ppa:webupd8team/sublime-text-2
sudo add-apt-repository -y ppa:no1wantdthisname/ppa
sudo add-apt-repository -y ppa:webupd8team/java

sudo sh -c 'echo "deb http://repo.ajenti.org/debian main main" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list.d/opera.list' 

wget http://repo.ajenti.org/debian/key -O- | sudo apt-key add -
wget http://deb.opera.com/archive.key -O- | sudo apt-key add -

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install mc guake synapse php5 php5-cli php5-fpm php5-mysqlnd nginx-full opera oracle-java7-installer doublecmd-gtk sublime-text filezilla awesome awesome-extra git cabextract moc zsh


sudo ln -s awesome.session /usr/share/gnome-session/sessions/awesome.session
sudo ln -s awesome.desktop /usr/share/applications/awesome.desktop
sudo ln -s gnome-awesome.desktop /usr/share/xsessions/gnome-awesome.desktop

cp -R /etc/xdg/awesome ~/.config
rm ~/.config/awesome/rc.lua

ln -s ~/dotfiles/rc.lua ~/.config/awesome/rc.lua
ln -s ~/dotfiles/rc.lua ~/rc.lua
ln -s ~/dotfiles/kbtweaks.sh ~/kbtweaks.sh
ln -s ~/dotfiles/.zshrc ~/.zshrc

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






#sudo sh -c 'echo "2" > /sys/module/hid_apple/parameters/fnmode'
#sudo sh -c 'echo "0" > /sys/module/hid_apple/parameters/iso_layout'
#setxkbmap -option altwin:swap_lalt_lwin
