refresh_tmux() {
    tmux refresh-client -S
}
PROMPT_COMMAND=refresh_tmux
PS1='▲ '
PS2="> "
