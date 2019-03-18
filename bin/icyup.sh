#!/bin/zsh

hash=`md5sum <<EOF
$RANDOM
EOF` 

fn=`echo $hash | awk '// { print $1 }'`

if [ "$1" != "" ]; then
	file=$1
	ext="${file##*.}"
	fullname="$fn.$ext"
	scp $1 emerald:icywww/stuff/$fullname
	echo "https://x.icyphox.sh/$fullname"
else
	echo "no path specified :v"
fi
