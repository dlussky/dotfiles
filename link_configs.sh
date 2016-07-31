#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#link config dirs and files to their destinations
while read lnk; do
	src="conf/$lnk"
	dst="$HOME/$lnk"
	echo $src -> $dst
	if [ -a "$src" ]
	then
		if [ -a "$dst" ]
		then
			echo dst already exists
		else
			parentdir="$(dirname "$dst")"
			mkdir -p "$parentdir"
            
            ln -s "$(pwd)/$src" "$dst"
		fi
	else
		echo src does not exists
	fi
done < misc/config_links.list
