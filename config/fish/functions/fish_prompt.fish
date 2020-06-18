function fish_prompt --description 'Write out the prompt'
    set -l cyan (set_color cyan)
    set -l prefix '▲'

    printf '\n'
    set_color cyan
    printf '%s' (prompt_pwd)
    set_color normal

    printf '%s\n' (__fish_git_prompt)
    printf '%s ' $prefix
 end
