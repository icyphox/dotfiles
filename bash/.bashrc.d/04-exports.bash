# export thingys
export EDITOR=nvim
export BROWSER=firefox
export SSH_KEY_PATH="~/.ssh/id_rsa"
export GPG_TTY=$(tty)
export INPUTRC=~/.inputrc
export PATH=$PATH:$HOME/.local/bin:/usr/local/go/bin:$HOME/go/bin:/usr/local/pgsql/bin
export PW_DIR=~/.pw
export PW_KEY=x@icyphox.sh
export _Z_CMD="n"
export MOZ_ACCELERATED=1
export CFLAGS="-O3 -pipe -march=native"
export CXXFLAGS="-O3 -pipe -march=native"
export MAKEFLAGS="-j4"
# not this time elgoog
export GOPROXY=direct

# gpg-agent
[[ -f "$HOME/.gpg-agent-info" ]] && {
    . "$HOME/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
}
