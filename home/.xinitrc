#!/bin/sh
 
#        _       _ _            
#  __  _(_)_ __ (_) |_ _ __ ___ 
#  \ \/ / | '_ \| | __| '__/ __|
# _ >  <| | | | | | |_| | | (__ 
#(_)_/\_\_|_| |_|_|\__|_|  \___|
#

setxkbmap -option 'grp:alt_shift_toggle' -layout us,ru -option 'compose:caps'
~/.fehbg &
eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info")"
sxhkd &
xrdb -l ~/.Xresources
st &
date -s "$(date -u -I) $(date -u +%H:%M:%S)"
compton &
xsetroot -cursor_name left_ptr
exec 2bwm
