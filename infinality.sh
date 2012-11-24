git clone git://github.com/Infinality/fontconfig-infinality.git fontconfig
sudo cp -R fontconfig/* /etc/fonts
sudo /etc/fonts/infinality/infctl.sh makestyles

wget http://citylan.dl.sourceforge.net/project/freetype/freetype2/2.4.10/freetype-2.4.10.tar.bz2
tar jxf freetype-2.4.10.tar.bz2

cd freetype-2.4.10
wget http://www.infinality.net/fedora/linux/zips/freetype-infinality-2.4.10-20120616_01-x86_64.tar.bz2
tar jxf freetype-infinality-2.4.10-20120616_01-x86_64.tar.bz2

patch -p1 < freetype-add-subpixel-hinting-infinality-20120616-01.patch 
patch -p1 < freetype-enable-subpixel-hinting-infinality-20120615-01.patch 
patch -p1 < freetype-entire-infinality-patchset-20120615-01.patch

./configure
make
sudo mkdir /usr/lib/freetype-infinality/
sudo find . -name libfreetype.so.6.9.0 -exec mv {} /usr/lib/freetype-infinality/  \;

sudo cp infinality-settings.sh /etc/profile.d
echo "export LD_PRELOAD=/usr/lib/freetype-infinality/libfreetype.so.6" > freetype-infinality.sh
sudo cp freetype-infinality.sh /etc/profile.d
sudo chmod +x /etc/profile.d/infinality-settings.sh
sudo chown +x /etc/profile.d/freetype-infinality.sh

cd /usr/lib/freetype-infinality
sudo ln -s libfreetype.so.6.9.0 libfreetype.so.6

sudo /etc/fonts/infinality/infctl.sh setstyle
