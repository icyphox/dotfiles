#!/bin/sh
 
#        _       _ _            
#  __  _(_)_ __ (_) |_ _ __ ___ 
#  \ \/ / | '_ \| | __| '__/ __|
# _ >  <| | | | | | |_| | | (__ 
#(_)_/\_\_|_| |_|_|\__|_|  \___|
#

setxkbmap -option 'grp:alt_shift_toggle' -layout us,ru -variant ',phonetic' -option 'compose:caps'
# ~/.fehbg &
eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info")"
# sxhkd &
xrdb -l ~/.Xresources
# st &
compton &
urxvtd &
xsetroot -cursor_name left_ptr
exec cwm
