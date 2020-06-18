set -gx MARKPATH ~/.marks

function mark
    mkdir -p $MARKPATH
    ln -s $PWD $MARKPATH/$argv
end

function unmark 
    rm -i $MARKPATH/(basename $PWD)
end

function marks
    for f in $MARKPATH/*
        printf '%s → %s\n' (basename $f) (readlink $f)
    end
end

function j -d 'The based jumper.'
    cd (realpath $MARKPATH/$argv) 2>/dev/null || printf '%s\n' "error: no such mark $argv"
end
