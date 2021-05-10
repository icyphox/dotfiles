alias gah='sudo $(fc -ln -1)'
alias vime="vim ~/.vimrc"
alias o="xdg-open"
alias gc="git commit -v -s"
alias ga="git add"
alias gd="git diff --minimal"
alias gl="git log --oneline --decorate --graph"
alias vim="nvim"
alias ..="cd .."
alias m="nail"
alias tb="nc termbin.com 9999 | xclip -sel c"

socks() {
    pkill ssh
    ssh -D 8008 emerald -fN
}

gst() {
    branch="$(git branch)"
    printf '%s\n' "$branch"
    git status --short 
}

up() {
	~/bin/icyup.sh "$1"
}

nvmon() {
	source ~/.nvm/nvm.sh
}

envac() {
	. .env/bin/activate
}

vpn() {
	~/bin/vpnon.sh
}

ggp() {
    git push "$(git remote show)" "$(git branch --show-current)" 
}

gcl() {
    git clone "$@"
}

ls() {
    if [ "$(uname)" == "OpenBSD" ]; then
        colorls -G "$@"
    else
        /bin/ls -G "$@"
    fi
}
