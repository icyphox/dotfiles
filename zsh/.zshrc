#               __             
#   ____  _____/ /_  __________
#  /_  / / ___/ __ \/ ___/ ___/
# _ / /_(__  ) / / / /  / /__  
#(_)___/____/_/ /_/_/   \___/  
#

# export thingys
export ZSH=/home/$USER/.oh-my-zsh
export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nvim
export SSH_KEY_PATH="~/.ssh/id_rsa"
export PATH=$PATH:$HOME/bin
export GPG_TTY=$(tty)
export INPUTRC=~/.inputrc
export PATH=$PATH:$HOME/Leet/Nim/bin
export PATH=$PATH:$HOME/.nimble/bin

# theme specefic
_nicy_prompt() {
	PROMPT=$("$HOME/Dotfiles/zsh/prompt")
}
precmd_functions+=_nicy_prompt
_nicy_prompt
COMPLETION_WAITING_DOTS="true"

# plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting k)

# sourced scripts
source $ZSH/oh-my-zsh.sh
source /usr/share/autojump/autojump.zsh
source $HOME/.aliases

# end and home keys
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# base16-shell 
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

