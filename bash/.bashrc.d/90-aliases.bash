alias vime="vim ~/.vimrc"
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

ls() {
    case "$OSTYPE" in
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
