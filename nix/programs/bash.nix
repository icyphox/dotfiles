{ config
, pkgs
, ...
}:

{
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" ];
    historyFile = "\$HOME/.bash_history";
    historyFileSize = 40000;
    historyIgnore = [ "ls" "exit" "kill" ];
    historySize = 40000;

    shellAliases = {
      o = "xdg-open";
      gc = "git commit -v -S";
      gst = "git status --short";
      ga = "git add";
      gd = "git diff --minimal";
      gl = "git log --oneline --decorate --graph";
      k = "kubectl";
      n = "z";
    };

    shellOptions = [
      "histappend"
      "autocd"
      "globstar"
      "checkwinsize"
      "cdspell"
      "dirspell"
      "expand_aliases"
      "dotglob"
      "gnu_errfmt"
      "histreedit"
      "nocasematch"
    ];

    sessionVariables = {

      TERM = "xterm-256color-italic";
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      PATH = "/etc/profiles/per-user/icy/bin:$PATH:$HOME/go/bin:$HOME/bin";
      CLICOLOR = "1";

    };

    # TODO: nixify this
    bashrcExtra = ''
      refresh_tmux() {
        tmux refresh-client -S
      }

      PROMPT_COMMAND=refresh_tmux
      PS1="\n\001\002▲\001\002 ";
      PS2="> "

      ggp() {
          if [[ "$1" == "-f" ]]; then 
              git push "$(git remote show)" -f "$(git branch --show-current)"
          else
              git push "$(git remote show)" "$(git branch --show-current)"
          fi
      }

      gpl() {
          if [[ "$1" != "" ]]; then
              branch="$1"
          else
              branch="$(git branch --show-current)"
          fi
          git pull -r "$(git remote show)" "$branch"
      }

      gco() {
          [[ "$1" == "" ]] && return 1

          git rev-parse --verify "$1" &> /dev/null
          if [ $? -eq 0 ]; then
              git checkout "$1"
          else
              git checkout -b "$1"
          fi
      }

      gaf() {
          git status --short | grep "^ M\|^ D\|^\?\?" | fzy | awk '{ print $2 }' | xargs git add
      }
    '';

    initExtra = ''
      __fzy_history__() {
          script='function P(b) { ++n; sub(/^[ *]/, "", b); if (!seen[b]++) { printf "%d\t%s%c", '$((BASH_REMATCH + 1))' - n, b, 0 } }
              NR==1 { b = substr($0, 2); next }
              /^\t/ { P(b); b = substr($0, 2); next }
              { b = b RS $0 }
              END { if (NR) P(b) }'


          output=$(
            set +o pipefail
            builtin fc -lnr -2147483648 2> /dev/null |   # ( $'\t '<lines>$'\n' )* ; <lines> ::= [^\n]* ( $'\n'<lines> )*
              command awk "$script"           |   # ( <counter>$'\t'<lines>$'\000' )*
              fzy --query "$READLINE_LINE"
          ) || return
          READLINE_LINE=''${output#*$'\t'}
          if [[ -z "$READLINE_POINT" ]]; then
            echo "$READLINE_LINE"
          else
            READLINE_POINT=0x7fffffff
          fi
      }

      bind -m emacs-standard -x '"\C-r": __fzy_history__'

      complete -cf doas
    '';

  };
}
