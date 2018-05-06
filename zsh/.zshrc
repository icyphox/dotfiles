#               __             
#   ____  _____/ /_  __________
#  /_  / / ___/ __ \/ ___/ ___/
# _ / /_(__  ) / / / /  / /__  
#(_)___/____/_/ /_/_/   \___/  
#

# export thingys
export ZSH=/home/icyphox/.oh-my-zsh
export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nvim
export SSH_KEY_PATH="~/.ssh/id_rsa"
export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$HOME/bin
export GPG_TTY=$(tty)
export INPUTRC=~/.inputrc

# plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# sourced scripts
source $ZSH/oh-my-zsh.sh
source /usr/share/autojump/autojump.zsh
# source $HOME/.cargo/env

# theme specefic
ZSH_THEME="simple"

# aliases
alias scrot="~/bin/scrot.sh"
alias icyinfo="~/bin/icyinfo.sh"
alias gah='sudo $(fc -ln -1)'
alias nvime='nvim ~/.config/nvim/init.vim'
alias up="~/bin/icyup.sh"
alias envac="source .env/bin/activate"
alias vim="nvim"
alias vi="nvim"
alias sxiv="sxiv -b"
alias todo="todo.sh"
alias ls="exa"
alias la="exa -al"
alias warcraft="wine Warcraft/Frozen\ Throne.exe -opengl"
alias socks="ssh -D 8008 boop"
alias vpn="sudo openvpn --config client.ovpn --script-security 2"

# end and home keys
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Defer initialization of nvm until nvm, node or a node-dependent command is
# run. Ensure this block is only run once if .bashrc gets sourced multiple times
# by checking whether __init_nvm is a function.
if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(type __init_nvm)" = function ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "$NVM_DIR"/nvm.sh
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

# base16-shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

