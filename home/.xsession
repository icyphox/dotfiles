#!/bin/sh

xmodmap ~/.xmodmap
eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info")"
export LC_CTYPE="en_US.UTF-8"
sxhkd &

# xorg things
xrdb -l ~/.Xresources
xsetroot -solid '#cccccc'
xrandr --dpi 96
xsetroot -cursor_name left_ptr
xrandr --output DP-1 --set "Broadcast RGB" "Full"

# touchpad setup
syndaemon -k -i 0.5 -d

redshift -l 12.972442:77.580643 -t 6400:5700 -m randr &

# xnotify
XNOTIFY_FIFO="$HOME/.cache/xnotify$DISPLAY.fifo"
export XNOTIFY_FIFO
rm -f $XNOTIFY_FIFO
mkfifo $XNOTIFY_FIFO
xnotify <$XNOTIFY_FIFO 3<>$XNOTIFY_FIFO &

# notifications
notifycpu() {
    tail -f /var/log/daemon |\
    awk '
        $5 ~ /^apmd.*:$/ && $0 ~ "external power status: not connected" && $(NF - 2) < 25 {
            printf "SEC:0\tTAG:power\tBattery is low: %s\n", $(NF - 2)
        }
        $5 ~ /^sensorsd.*:$/ && $7 == "exceeds" {
            printf "SEC:5\tTAG:temp\tTemperature is at %d°C\n", $9
        }
        {
            fflush()
        }
    '
}

notifycpu > "$XNOTIFY_FIFO" &

# window manager
~/leet/cwm/cwm
