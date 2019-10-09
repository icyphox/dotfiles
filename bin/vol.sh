#!/usr/bin/env bash

fg="$(xres color15)"
light="$(xres color8)"

while getopts idq options
do
	case $options in
		i)
			pamixer -i 2
			;;

		d)
			pamixer -d 2
			;;
		q)
			cur_vol=$(pamixer --get-volume-human)
            if [[ "$cur_vol" == "muted" ]]; then
				echo -ne "%{F$light}vol %{F$fg}muted"
			else
			    echo -ne "%{F$light}vol %{F$fg}$cur_vol"
			fi
			;;
	esac
done
