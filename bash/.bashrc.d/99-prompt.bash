red="\e[31m"
grn="\e[32m"
ylw="\e[33m"
cyn="\e[36m"
blu="\e[34m"
prp="\e[35m"
bprp="\e[35;1m"
gry="\e[94m"
rst="\e[0m"

git_branch() {
    [[ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]] && {
        local git_status="$(git status 2> /dev/null)"
        local on_branch="On branch ([^${IFS}]*)"
        local on_commit="HEAD detached at ([^${IFS}]*)"
        status="$(git status --porcelain 2> /dev/null)"
        local exit="$?"

        if [[ "$exit" -eq 0 ]]; then
            if [[ "${#status}" -eq 0 ]]; then
                color="${grn}"
                sym="·"
            else
                color="${red}"
                sym="×"
            fi
        else
            printf ''
        fi


        if [[ $git_status =~ $on_branch ]]; then
            local branch=${BASH_REMATCH[1]}
            printf '%b'  " ($branch $color$sym$rst)"
        elif [[ $git_status =~ $on_commit ]]; then
            local commit=${BASH_REMATCH[1]}
            printf '%b' " ($commit $color$sym$rst)"
        fi
    }
}

short_pwd() {
    wd=$(dirs +0)
    sed 's:\([^/]\)[^/]*/:\1/:g' <<< "${wd/#$HOME/\~}"
}

prompt_pwd() {
    printf '%b' "\001${cyn}\002$(short_pwd)\001${rst}\002"
}

rootornot() {
    [[ "$(id -u)" -eq 0 ]] &&
        printf '%b' "\001${red}\002#\001${rst}\002"
}

PS1='\n$(prompt_pwd)$(git_branch)\n▲$(rootornot) '
PS2="> "
