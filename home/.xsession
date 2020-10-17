#!/bin/sh
 
#        _       _ _            
#  __  _(_)_ __ (_) |_ _ __ ___ 
#  \ \/ / | '_ \| | __| '__/ __|
# _ >  <| | | | | | |_| | | (__ 
#(_)_/\_\_|_| |_|_|\__|_|  \___|
#

xmodmap ~/leet/xmodmap/xmodmap.workman
eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info")"
export LC_CTYPE="en_US.UTF-8"
export ENV="$HOME/.kshrc"
sxhkd &
~/.fehbg &
xrdb -l ~/.Xresources &
syndaemon -k -i 0.5 -d
xsetroot -cursor_name left_ptr
st &
cwm
