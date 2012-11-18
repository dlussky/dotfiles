sh -c 'echo "2" > /sys/module/hid_apple/parameters/fnmode'
sh -c 'echo "0" > /sys/module/hid_apple/parameters/iso_layout'
setxkbmap -option altwin:swap_lalt_lwin
