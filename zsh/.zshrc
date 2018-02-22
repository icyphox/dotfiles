#               __             
#   ____  _____/ /_  __________
#  /_  / / ___/ __ \/ ___/ ___/
# _ / /_(__  ) / / / /  / /__  
#(_)___/____/_/ /_/_/   \___/  
#

# export thingys
export ZSH=/home/icyphox/.oh-my-zsh
export BROWSER=/usr/bin/firefox-nightly
export EDITOR=/usr/bin/nvim
export SSH_KEY_PATH="~/.ssh/id_rsa"
export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$HOME/bin
export GPG_TTY=$(tty)
export INPUTRC=~/.inputrc

# theme specefic
ZSH_THEME="spaceship"
export SPACESHIP_CHAR_SYMBOL="> "
export SPACESHIP_USER_SHOW=always
export SPACESHIP_HOST_SHOW=always

# plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# aliases
alias icysite="cd ~/leet/icysite"
alias scrot="~/bin/scrot.sh"
alias icyinfo="~/bin/icyinfo.sh"
alias gah='sudo $(fc -ln -1)'
alias nvime='nvim ~/.config/nvim/init.vim'
alias up="~/bin/icyup.sh"
alias vim="nvim"
alias vi="nvim"
alias sxiv="sxiv -b"

# end and home keys
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# gnome-keyring thing
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
