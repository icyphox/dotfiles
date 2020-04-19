#!/bin/sh
 
#        _       _ _            
#  __  _(_)_ __ (_) |_ _ __ ___ 
#  \ \/ / | '_ \| | __| '__/ __|
# _ >  <| | | | | | |_| | | (__ 
#(_)_/\_\_|_| |_|_|\__|_|  \___|
#

setxkbmap -option 'grp:alt_shift_toggle' -layout us,ru -variant ',phonetic' -option 'compose:caps' &
eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info")"
export LC_CTYPE="en_US.UTF-8"
export ENV="$HOME/.kshrc"
# sxhkd &
~/.fehbg &
xrdb -l ~/.Xresources &
compton &
urxvtd &
xsetroot -cursor_name left_ptr -solid steelblue &
cwm
