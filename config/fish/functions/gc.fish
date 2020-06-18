# Defined in - @ line 1
function gc --wraps='git commit -v -s' --description 'alias gc=git commit -v -s'
  git commit -v -s $argv;
end
