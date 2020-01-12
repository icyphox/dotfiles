#!/bin/sh
 
#        _       _ _            
#  __  _(_)_ __ (_) |_ _ __ ___ 
#  \ \/ / | '_ \| | __| '__/ __|
# _ >  <| | | | | | |_| | | (__ 
#(_)_/\_\_|_| |_|_|\__|_|  \___|
#

setxkbmap -option 'grp:alt_shift_toggle' -layout us,ru -option 'compose:caps'
#devmon &
~/.fehbg &
eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info")"
sxhkd &
xrdb -l ~/.Xresources
st &
exec ~/leet/2bwm/2bwm
