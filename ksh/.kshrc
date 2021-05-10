HISTFILE=$HOME/.ksh_history
HISTSIZE=20000

for i in ~/.kshrc.d/[0-9]*; do
    . "$i"
done
