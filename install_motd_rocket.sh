#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "cat /home/dlussky/dotfiles/misc/rocket.txt" | sudo tee /etc/update-motd.d/15-rocket
sudo chmod +x /etc/update-motd.d/15-rocket
sudo rm /etc/update-motd.d/10-help-text