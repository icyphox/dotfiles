#!/usr/bin/env bash

n=3; fn=$(tr -cd '[:alnum:]' < /dev/urandom | head -c$n)

latest="$HOME/pics/scrots/latest.png"

upload() {
	file=$1
	ext="${file##*.}"
	fullname="$fn.$ext"
	scp -P 443 "$1" emerald:icywww/uploads/"$fullname"
	echo "https://x.icyphox.sh/$fullname"
	echo "https://x.icyphox.sh/$fullname" | xclip -selection clipboard
}

if [ "$1" == "l" ]; then
    upload "$latest" 
elif [ "$1" != "l" ]; then
   upload "$1" 
else
	echo "no path specified :v"
fi
