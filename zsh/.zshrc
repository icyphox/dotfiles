#               __             
#   ____  _____/ /_  __________
#  /_  / / ___/ __ \/ ___/ ___/
# _ / /_(__  ) / / / /  / /__  
#(_)___/____/_/ /_/_/   \___/  
#

# export thingys
export ZSH=/home/icyphox/.oh-my-zsh
export BROWSER=/usr/bin/firefox-nightly
export EDITOR=/usr/bin/vim
export SSH_KEY_PATH="~/.ssh/rsa_id"
export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin
export GPG_TTY=$(tty)
export INPUTRC=~/.inputrc

ZSH_THEME="simple"

# plugins
#plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# aliases
alias icysite="cd ~/leet/icysite"
alias scrot="~/scripts/scrot.sh"
alias icyinfo="~/scripts/icyinfo.sh"
alias gah='sudo $(fc -ln -1)'
alias lol="base64 </dev/urandom | lolcat"
alias up="~/scripts/icyup.py"

# end and home keys
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# gnome-keyring thing
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
