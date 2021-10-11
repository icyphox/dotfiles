#!/usr/bin/env bash

# stolen from @nerdypepper

echo 'set incremental-search true

set recolor "true"

set default-bg "'$( get_xres color0 )'"
set default-fg "'$( get_xres color7 )'"

set completion-bg "'$( get_xres color0 )'"
set completion-fg "'$( get_xres color7 )'"
set completion-highlight-bg "'$( get_xres color4 )'"
set completion-highlight-fg "'$( get_xres color7 )'"

set statusbar-bg "'$( get_xres color4 )'"
set statusbar-fg "'$( get_xres color0 )'"

set inputbar-bg "'$( get_xres color0 )'"
set inputbar-fg "'$( get_xres color7 )'"

set recolor-darkcolor "'$( get_xres color7 )'"
set recolor-lightcolor "'$( get_xres color0 )'"

set window-height "800"
set window-width "600"

set adjust-open "width"
set statusbar-home-tilde "true"
set statusbar-h-padding "50"
set statusbar-v-padding "50"

set font "SF Mono 12"

' > ~/.config/zathura/zathurarc

