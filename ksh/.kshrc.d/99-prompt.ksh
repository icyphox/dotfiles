set -o emacs
cr=$(print -n '\r')
esc=$(print -n '\033')
ps1flag=$(print -n '\001')

red="$esc[31m"
cyn="$esc[36m"
rst="$esc[0m"

git_status() {
    [[ -n "$(git rev-parse --is-inside-work-tree)" ]] ||
        return

    branch="$(git branch --show-current)"
    [[ "$branch" == "" ]] && branch="$(git rev-parse --short HEAD)"
    
    [[ "$(git status --porcelain)" != "" ]] ||
        clean=" *"

    printf ' (%s%s)' "$branch" "$clean"
}

# first, set the rootornot part
if [[ $(id -u) = 0 ]]; then
	PS1="$ps1flag$red$ps1flag#$ps1flag$rst$ps1flag"
else
	PS1=
fi

# then, combine it all
PS1="$ps1flag$cr
$ps1flag$cyn$ps1flag\$PWD$rst$(git_status)$ps1flag$rst$ps1flag
▲$PS1 "
PS2="> "
