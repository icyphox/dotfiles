# Defined in - @ line 1
function clip --wraps='xclip -sel c' --description 'alias clip=xclip -sel c'
  xclip -sel c $argv;
end
