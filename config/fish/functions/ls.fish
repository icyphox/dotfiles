# Defined in - @ line 1
function ls --description 'alias ls=colorls -G'
  switch (uname)
    case OpenBSD
      colorls -G $argv
    case Darwin
      /bin/ls -G $argv
  end
end
