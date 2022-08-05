ggp() {
    [[ "$1" == "-f" ]] && {
        git push "$(git remote show)" -f "$(git branch --show-current)"
    }
    git push "$(git remote show)" "$(git branch --show-current)"
}

gpl() {
    git pull -r "$(git remote show)" "$(git branch --show-current)"
}

gpm() {
    git pull -r origin master
}

gco() {
    [[ "$1" == "" ]] && return 1

    git rev-parse --verify "$1" &> /dev/null
    if [ $? -eq 0 ]; then
        git checkout "$1"
    else
        git checkout -b "$1"
    fi
}

gaf() {
    git status --short | grep "^ M\|^ D\|^\?\?" | fzy | awk '{ print $2 }' | xargs git add
}
