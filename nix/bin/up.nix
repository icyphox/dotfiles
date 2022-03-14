{ pkgs, ... }:
let
  name = "up";
  xclip = "${pkgs.xclip}/bin/xclip";
in
pkgs.writeScriptBin name
  ''
    id=$( cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 3 | head -n 1 )

    if [ $# != 1 ]; then
        echo "needs an arg"
    else
        if [ -f "$1" ]; then
            ext="''${1##*.}"
            id="$id.$ext"
            scp "$1" ferrn:~/www/nerd/uploads/"$id"
            echo "https://u.peppe.rs/$id"
            echo "https://u.peppe.rs/$id" | ${xclip} -selection clipboard
            echo "https://u.peppe.rs/$id" | ${xclip} -i
        else
            echo "file does not exist"
        fi
    fi
  ''
