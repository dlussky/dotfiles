#!/bin/bash
set -euox pipefail
IFS=$'\n\t'

BAT_PACKAGE_TMP_PATH="/tmp/bat.deb"

#качаем свежий deb пакет, парся ссылку из данных о последнем релизе на гитхабе
curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" \
  | grep "browser_download_url" \
  | grep "amd64.deb" \
  | grep -v "sha256\|musl" \
  | cut -d '"' -f 4 \
  | wget -O $BAT_PACKAGE_TMP_PATH  -qi -


sudo dpkg -i $BAT_PACKAGE_TMP_PATH
rm $BAT_PACKAGE_TMP_PATH

echo "Latest bat installed successfully"