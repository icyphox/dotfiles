# Defined in - @ line 1
function gpa --wraps='git push all master' --description 'alias gpa=git push all master'
  git push all master $argv;
end
