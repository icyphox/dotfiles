export MARKPATH=$HOME/.marks

function mark {
  mkdir -p "$MARKPATH"; ln -s "$PWD" "$MARKPATH/$1"
}

function unmark {
    rm -i "$MARKPATH/"$(basename $PWD)""
}

function marks {
    for f in "$MARKPATH"/*; do
        printf '%s → %s\n' "$(basename "$f")" "$(readlink "$f")"
    done
}

function j {
  cd -P "$MARKPATH/$1" 2>/dev/null || printf '%s\n' "error: no such mark $1"
}
