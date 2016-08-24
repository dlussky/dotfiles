#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "#!/bin/sh
cat /home/dlussky/dotfiles/misc/rocket.txt" | sudo tee /etc/update-motd.d/15-rocket
sudo chmod +x /etc/update-motd.d/15-rocket
