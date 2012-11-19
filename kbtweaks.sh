#making apple keyboard behave like ordinary one
#inverse F## keys behaviour (now media only with fn)
sh -c 'echo "2" > /sys/module/hid_apple/parameters/fnmode'
#normal layout (tilda under escape)
sh -c 'echo "0" > /sys/module/hid_apple/parameters/iso_layout'
