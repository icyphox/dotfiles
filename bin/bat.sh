#!/usr/bin/env bash

fg="$(xres color15)"
light="$(xres color8)"

cap=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

if [[ "$1" == "-n" ]]; then
    echo "$cap%"
else
    if [[ "$status" = "Charging" ]]
    then
    	echo -ne "%{F$light}+bat %{F$fg}$cap%"
    else
    	echo -ne "%{F$light}bat %{F$fg}$cap%"
    fi
fi
