#!/bin/bash

if [ "$1" != "" ]; then
	scp $1 file boop:upload/
	file=$(basename $1)
	echo "https://xix.ph0x.me/$file"
else
	echo "no path specified :v"
fi
