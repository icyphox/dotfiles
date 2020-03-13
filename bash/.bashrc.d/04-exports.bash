# export thingys
export BROWSER=/usr/local/bin/vimb
export EDITOR=/usr/bin/vim
export SSH_KEY_PATH="~/.ssh/id_rsa"
export PATH=$HOME/bin:$PATH
export GPG_TTY=$(tty)
export INPUTRC=~/.inputrc
#export PATH=$PATH:$HOME/leet/Nim/bin
export PATH=$PATH:$HOME/.nimble/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/pgsql/bin
export PW_DIR=~/passwords
export PW_KEY=x@icyphox.sh
export _Z_CMD="j"
export CFLAGS="-O3 -pipe -march=native"
export CXXFLAGS="-O3 -pipe -march=native"
export MAKEFLAGS="-j4"

# gpg-agent

[[ -f "$HOME/.gpg-agent-info" ]] && {
    . "$HOME/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
}

