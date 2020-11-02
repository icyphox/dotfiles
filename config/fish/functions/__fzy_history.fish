# Defined in /tmp/fish.wuVePn/__fzy_history.fish @ line 1
function __fzy_history
    history | fzy | read -l cmd
    commandline -f repaint
    commandline $cmd
end
