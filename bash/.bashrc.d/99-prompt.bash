refresh_tmux() {
    tmux refresh-client -S
}
PROMPT_COMMAND=refresh_tmux
PS1="\n\001\e[0;36m\002▲\001\e[0m\002 ";
PS2="> "
