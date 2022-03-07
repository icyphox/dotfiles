alias o="xdg-open"
alias gc="git commit -v -S"
alias gst="git status --short"
alias ga="git add"
alias gd="git diff --minimal"
alias gl="git log --oneline --decorate --graph"
alias vim="nvim"
alias k="kubectl"

nvmon() {
	source ~/.nvm/nvm.sh
}

envac() {
	source .env/bin/activate
}

vpn() {
	~/bin/vpnon.sh
}

dt() {
    time.sh -n
}

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

ls() {
    case "$OSTYPE" in
        "linux"*)
            /bin/ls "$@"
            ;;
        "darwin"*)
            /bin/ls -G "$@"
            ;;
        *"bsd"*)
            colorls -G "$@"
            ;;
    esac
}

m() {
    case "$OSTYPE" in
        "darwin"*)
            s-nail "$@"
            ;;
        *"bsd"*)
            nail "$@"
            ;;
    esac
}
