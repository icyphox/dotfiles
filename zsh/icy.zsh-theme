NEWLINE=$'\n'
PROMPT='${NEWLINE}%{$fg[cyan]%}%~%{$fg[yellow]%}$(git_prompt_info)${NEWLINE}%{$fg[magenta]%}›%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" \e[0;31m×" 
ZSH_THEME_GIT_PROMPT_CLEAN=" \e[0;32m•"
