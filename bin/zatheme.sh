#!/usr/bin/env bash

# stolen from @nerdypepper

echo 'set incremental-search true

set recolor "true"

set default-bg "'$( xres color0 )'"
set default-fg "'$( xres color7 )'"

set completion-bg "'$( xres color0 )'"
set completion-fg "'$( xres color7 )'"
set completion-highlight-bg "'$( xres color4 )'"
set completion-highlight-fg "'$( xres color7 )'"

set statusbar-bg "'$( xres color4 )'"
set statusbar-fg "'$( xres color0 )'"

set inputbar-bg "'$( xres color0 )'"
set inputbar-fg "'$( xres color7 )'"

set recolor-darkcolor "'$( xres color7 )'"
set recolor-lightcolor "'$( xres color0 )'"

set window-height "800"
set window-width "600"

set adjust-open "width"
set statusbar-home-tilde "true"
set statusbar-h-padding "50"
set statusbar-v-padding "50"

set font "SF Mono 12"

' > ~/.config/zathura/zathurarc

