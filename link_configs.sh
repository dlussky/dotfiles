#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#link config dirs and files to their destinations
while read lnk; do
	src="conf/$lnk"
	dst="$HOME/$lnk"
	echo $src will be linked to $dst
	if [ -e "$src" ]
	then
		if [ -e "$dst" ]
		then
			echo dst already exists
		else
			parentdir="$(dirname "$dst")"
			mkdir -p "$parentdir"

			ln -s "$(pwd)/$src" "$dst"
			echo done
		fi
	else
		echo src does not exists
	fi
done < misc/config_links.list
