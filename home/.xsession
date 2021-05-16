#!/bin/sh
 
#        _       _ _            
#  __  _(_)_ __ (_) |_ _ __ ___ 
#  \ \/ / | '_ \| | __| '__/ __|
# _ >  <| | | | | | |_| | | (__ 
#(_)_/\_\_|_| |_|_|\__|_|  \___|
#

xmodmap ~/.xmodmap
eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info")"
export LC_CTYPE="en_US.UTF-8"
export ENV="$HOME/.kshrc"
sxhkd &
xrdb -l ~/.Xresources &
~/bin/bgfill
syndaemon -k -i 0.5 -d
xsetroot -cursor_name left_ptr
redshift -l 12.972442:12.972442 &

# xnotify
XNOTIFY_FIFO="$HOME/.cache/xnotify$DISPLAY.fifo"
export XNOTIFY_FIFO
rm -f $XNOTIFY_FIFO
mkfifo $XNOTIFY_FIFO
xnotify <$XNOTIFY_FIFO 3<>$XNOTIFY_FIFO &

st &
~/code/bar/bar "somestring" &
~/leet/cwm/cwm
