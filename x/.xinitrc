#!/usr/bin/env dash 
 
#        _       _ _            
#  __  _(_)_ __ (_) |_ _ __ ___ 
#  \ \/ / | '_ \| | __| '__/ __|
# _ >  <| | | | | | |_| | | (__ 
#(_)_/\_\_|_| |_|_|\__|_|  \___|
#

setxkbmap -option compose:caps
urxvtd &
source ~/.fehbg
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
libinput-gestures-setup start
exec i3 
