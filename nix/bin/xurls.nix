{ pkgs, ... }:

let
  name = "xurls";
  fzy = "${pkgs.fzy}/bin/fzy";
in
pkgs.writeShellScriptBin name
  ''
    content="$(tmux capture-pane -J -p)"

    mapfile -t urls < <(echo "$content" | grep -oE '(https?|ftp|file):/?//[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]')
    mapfile -t wwws < <(echo "$content" | grep -oE '(http?s://)?www\.[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}(/\S+)*' | grep -vE '^https?://' |sed 's/^\(.*\)$/http:\/\/\1/')
    mapfile -t ips  < <(echo "$content" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}(:[0-9]{1,5})?(/\S+)*' |sed 's/^\(.*\)$/http:\/\/\1/')
    mapfile -t gits < <(echo "$content" | grep -oE '(ssh://)?git@\S*' | sed 's/:/\//g' | sed 's/^\(ssh\/\/\/\)\{0,1\}git@\(.*\)$/https:\/\/\2/')
    
    items="$(printf '%s\n' "''${urls[@]}" "''${wwws[@]}" "''${ips[@]}" "''${gits[@]}" |
        grep -v '^$' |
        sort -u |
        nl -w3 -s ' '
    )"

    [ -z "$items" ] && exit

    u="$(${fzy} <<< "$items" | awk '{ print $2 }')"
    $BROWSER "$u"
  ''

