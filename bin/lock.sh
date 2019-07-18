#!/usr/bin/env bash

image_file=/tmp/screen_lock.png
import -window root "$image_file"
resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')
filters="gblur=sigma=15,hue=s=0,eq=brightness=-0.09"
ffmpeg -y -loglevel 0 -s "$resolution" -f x11grab -i $DISPLAY -vframes 1 \
-vf "$filters" "$image_file"
i3lock -i $image_file -l '#ffffff' -o '#99C794' -w '#EC5f67'
