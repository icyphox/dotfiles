#!/usr/bin/env bash
 
#        _       _ _            
#  __  _(_)_ __ (_) |_ _ __ ___ 
#  \ \/ / | '_ \| | __| '__/ __|
# _ >  <| | | | | | |_| | | (__ 
#(_)_/\_\_|_| |_|_|\__|_|  \___|
#

setxkbmap -option 'grp:alt_shift_toggle' -layout us,ru -option 'compose:caps'
urxvtd &
devmon &
~/.fehbg &
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
sxhkd &
~/bin/bar.sh &
xrdb -l ~/.Xresources
exec xfwm4
