# Defined in - @ line 1
function gd --wraps='git diff --minimal' --description 'alias gd=git diff --minimal'
  git diff --minimal $argv;
end
