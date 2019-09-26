#!/usr/bin/env bash

import -window root /tmp/lock.png
convert /tmp/lock.png -scale 10% -scale 1000% /tmp/lock.png

# stolen from xero
function datamosh() {
	fileSize=$(wc -c < "$file")
	headerSize=10
	skip=$(shuf -i "$headerSize"-"$fileSize" -n 1)
	count=$(shuf -i 1-10 -n 1)
	for i in $(seq 1 $count);do byteStr=$byteStr'\x'$(shuf -i 0-255 -n 1); done;   
	printf $byteStr | dd of="$file" bs=1 seek=$skip count=$count conv=notrunc >/dev/null 2>&1
}

#steps=$(shuf -i 20-30 -n 1)
#for i in $(seq 1 $steps);do datamosh "$file"; done

#convert /tmp/lock.jpg /tmp/lock.png >/dev/null 2>&1
#rm /tmp/lock.jpg
#file=/tmp/lock.png

i3lock -u -i /tmp/lock.png
rm /tmp/lock.png
