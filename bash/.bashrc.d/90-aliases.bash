alias gah='sudo $(fc -ln -1)'
alias vime="vim ~/.vimrc"
alias o="xdg-open"
alias gc="git commit -v -s"
alias gst="git status --short"
alias ga="git add"
alias gd="git diff --minimal"
alias gl="git log --oneline --decorate --graph"
alias ls="ls --color"
alias vim="vim"

socks() {
    pkill ssh
    ssh -D 8008 emerald -fN
}

up() {
	~/bin/icyup.sh "$1"
}

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
    git push "$(git remote show)" "$(git branch --show-current)" 
}
