# Defined in - @ line 1
function m --wraps=nail --description 'alias m=nail'
  switch (uname)
    case OpenBSD
      nail  $argv;
	case Darwin
	  s-nail $argv;
  end
end
