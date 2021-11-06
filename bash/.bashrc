# better history syncing
shopt -s histappend
export HISTCONTROL=ignoreboth:erasedups
HISTSIZE=40000
HISTFILESIZE=40000

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

# Ctrl+W kills word
stty werase undef
bind '"\C-w": backward-kill-word'

# fzy reverse search
__fzy_history() {
    ch="$(fc -l 1 | awk -F'\t' '{print $2}' | sort -u | fzy)"
    : "${ch#"${ch%%[![:space:]]*}"}"
    printf "$_"
}

bind -x '"\C-r": READLINE_LINE=$(__fzy_history); READLINE_POINT="${#READLINE_LINE}"'

complete -cf doas

# z (darwin)
[[ -f /usr/local/etc/profile.d/z.sh ]] &&
. /usr/local/etc/profile.d/z.sh

# z (bsd)
[[ -f ~/bin/z.sh ]] &&
. ~/bin/z.sh

for i in ~/.bashrc.d/[0-9]*; do
    . "$i"
done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/icy/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/icy/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/icy/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/icy/Downloads/google-cloud-sdk/completion.bash.inc'; fi
