set -o emacs
lf='
'
cr=$(print -n '\r')
esc=$(print -n '\033')
ps1flag=$(print -n '\001')

red="$esc[31m"
grn="$esc[32m"
ylw="$esc[33m"
cyn="$esc[36m"
blu="$esc[34m"
prp="$esc[35m"
bprp="$esc[35;1m"
gry="$esc[94m"
rst="$esc[0m"

git_status() {
	if [[ -d .git ]]; then
		git_status=$(git status 2>/dev/null)
		on_branch=
	fi
}

# first, set the rootornot part
if [[ $(id -u) = 0 ]]; then
	PS1="$ps1flag$red$ps1flag#$ps1flag$rst$ps1flag"
else
	PS1=
fi

# then, combine it all
PS1="$ps1flag$cr
$ps1flag$cyn$ps1flag\$PWD$ps1flag$rst$ps1flag
▲$PS1 "
PS2="> "
