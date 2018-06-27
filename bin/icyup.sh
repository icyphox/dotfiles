#!/bin/zsh

hash=`md5sum <<EOF
$RANDOM
EOF` 

fn=`echo $hash | awk '// { print $1 }'`

if [ "$1" != "" ]; then
	echo $fn
	scp $1 boop:www/upload/$fn
	echo "https://xix.ph0x.me/$fn"
else
	echo "no path specified :v"
fi
