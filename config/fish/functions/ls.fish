# Defined in - @ line 1
function ls --wraps='colorls -G' --description 'alias ls=colorls -G'
  colorls -G $argv;
end
