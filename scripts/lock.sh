#!/bin/bash

image_file=/tmp/screen_lock.png
resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')
filters='gblur=sigma=15'
ffmpeg -y -loglevel 0 -s "$resolution" -f x11grab -i $DISPLAY -vframes 1 \
  -vf "$filters" "$image_file" 
i3lock -i $image_file -l '#222222' -o '#99C794' -w '#EC5f67'


