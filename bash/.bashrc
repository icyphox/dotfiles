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

complete -cf doas

# z
# source ~/leet/z/z.sh

for i in ~/.bashrc.d/[0-9]*; do
    . "$i"
done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
