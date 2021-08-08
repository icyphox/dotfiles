PS1='$(~/dotfiles/prompt/prompt) '
PS2="> "

# terminal title
trap 'printf "\033]2;$(history 1 | sed "s/^[ ]*[0-9]*[ ]*//g"): $PWD\007"' DEBUG

