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

# better history syncing
shopt -s histappend
export HISTCONTROL=ignoreboth:erasedups
HISTSIZE=1000
HISTFILESIZE=2000

# cool options for cool kids
shopt -s \
    autocd \
    globstar \
    checkwinsize \
    cdspell \
    dirspell \
    expand_aliases \
    dotglob \
    gnu_errfmt \
    histreedit \
    nocasematch 

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set colored-stats on'
bind 'set completion-display-width 1'
bind 'TAB:menu-complete'

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# source aliases and prompt
source ~/.bash/aliases
source ~/.bash/prompt

# z
export _Z_CMD="j"
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# title
#trap 'echo -ne "\033]0;$BASH_COMMAND\007"' DEBUG
