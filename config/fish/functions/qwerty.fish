# Defined in /tmp/fish.kneo2V/qwerty.fish @ line 2
function qwerty --wraps=setxkbmap\ -option\ \'grp:alt_shift_toggle\'\ -layout\ us,ru\ -variant\ \',phonetic\'\ -option\ \'compose:caps\' --description alias\ qwerty=setxkbmap\ -option\ \'grp:alt_shift_toggle\'\ -layout\ us,ru\ -variant\ \',phonetic\'\ -option\ \'compose:caps\'
  setxkbmap -option 'grp:alt_shift_toggle' -layout us,ru -variant ',phonetic' -option 'compose:caps' $argv;
  export KEYBOARD_LAYOUT="qwerty"
end
