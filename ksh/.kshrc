HISTFILE=$HOME/.ksh_history
HISTSIZE=20000

set -o emacs

for i in ~/.kshrc.d/[0-9]*; do
    . "$i"
done
