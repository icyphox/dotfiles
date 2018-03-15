#!/bin/bash

if [ "$1" != "" ]; then
	file=$(basename $1)
	scp $1 file boop:www/upload/
	echo "https://xix.ph0x.me/$file"
else
	echo "no path specified :v"
fi
