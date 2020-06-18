complete -c j -f -r

set -l paths ""

for f in $MARKPATH/*
    set -a paths (basename $f)
end

complete -c j -a "$paths"
