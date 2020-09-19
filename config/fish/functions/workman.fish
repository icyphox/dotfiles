# Defined in /tmp/fish.tReLyy/workman.fish @ line 2
function workman --wraps='setxkbmap us; xmodmap xmodmap/xmodmap.workman && xset r 66' --description 'alias workman=setxkbmap us; xmodmap xmodmap/xmodmap.workman && xset r 66'
  setxkbmap us; xmodmap ~/leet/xmodmap/xmodmap.workman && xset r 66 $argv;
  export KEYBOARD_LAYOUT="workman"
end
