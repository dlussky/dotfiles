#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#fix for splash on nvidia cards

echo "GRUB_GFXPAYLOAD_LINUX=1920x1080x32" | sudo tee -a /etc/default/grub
echo "FRAMEBUFFER=y" | sudo tee -a /etc/initramfs-tools/conf.d/splash

sudo sed -i'' 's/^adjust_timeout$/#&/' /etc/grub.d/30_os-prober

sudo grub-update