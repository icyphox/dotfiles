# Defined in /tmp/fish.ybggTQ/gc.fish @ line 2
function gc --wraps='git commit -v' --wraps='git commit -v' --description 'alias gc=git commit -v'
  git commit -v $argv;
end
