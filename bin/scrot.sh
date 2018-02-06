#!/bin/bash

# screenshootin' lika boss
n=6; output=$(tr -cd '[:alnum:]' < /dev/urandom | head -c$n)
scrot ~/pics/scrots/$output.png
notify-send 'screenshot taken'

