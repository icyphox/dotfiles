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
export PATH=$HOME/bin:$PATH
export GPG_TTY=$(tty)
export INPUTRC=~/.inputrc
export PATH=$PATH:$HOME/leet/Nim/bin
export PATH=$PATH:$HOME/.nimble/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin

# zsh setup
autoload -Uz compinit colors add-zsh-hook history-search-end
colors
compinit
zstyle ':completion:*' list-colors "di=34"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
export ZLE_REMOVE_SUFFIX_CHARS=''
setopt extended_glob
setopt autocd

# partial history matching
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# command history
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# prompt
_nicy_prompt() {
	PROMPT="$(~/dotfiles/zsh/prompt)"
}
add-zsh-hook precmd _nicy_prompt

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# base16-shell 
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# fpath
fpath=($HOME/.zsh/zsh-completions/src $fpath)

# sourced scripts
source $HOME/.aliases
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# autojump
[[ -s /home/icy/.autojump/etc/profile.d/autojump.sh ]] && source /home/icy/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u


# emacsy binds
bindkey -e
# end and home keys
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line


