set fish_greeting

set -gx PATH ~/bin ~/.local/bin ~/leet/Nim/bin ~/.nimble/bin \
/usr/local/bin /usr/bin /bin /sbin /usr/sbin /usr/X11R6/bin \
~/go/bin /usr/local/go/bin

set -gx EDITOR nvim
set -gx BROWSER iridium
set -gx PW_KEY x@icyphox.sh

# source ~/.config/fish/functions/marks.fish

function fish_user_key_bindings
    bind \cr '__fzy_history (commandline -b)'
end

# workaround for slow completions on macOS
function __fish_describe_command; end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/icy/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/icy/Downloads/google-cloud-sdk/path.fish.inc'; end
set -g fish_user_paths "/usr/local/opt/node@14/bin" $fish_user_paths
set -gx PATH $PATH $HOME/.krew/bin


# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

