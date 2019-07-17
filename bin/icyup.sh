#!/usr/bin/env bash

n=3; fn=$(tr -cd '[:alnum:]' < /dev/urandom | head -c$n)

if [ "$1" != "" ]; then
	file=$1
	ext="${file##*.}"
	fullname="$fn.$ext"
	scp -P 443 "$1" emerald:icywww/stuff/"$fullname"
	echo "https://x.icyphox.sh/$fullname"
	echo "https://x.icyphox.sh/$fullname" | xclip -selection clipboard
else
	echo "no path specified :v"
fi
