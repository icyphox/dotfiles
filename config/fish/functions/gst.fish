# Defined in /tmp/fish.9tYpdR/gst.fish @ line 2
function gst --wraps='git status --short' --description 'alias gst=git status --short'
  git status --short $argv;
end
