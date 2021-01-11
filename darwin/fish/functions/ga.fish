# Defined in - @ line 1
function ga --wraps='git add' --description 'alias ga=git add'
  git add $argv;
end
