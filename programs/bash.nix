{ config
, pkgs
, ...
}:
let
  awk = "${pkgs.gawk}/bin/awk";
  fzy = "${pkgs.fzy}/bin/fzy";
in
{
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
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

      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      PATH = "/etc/profiles/per-user/icy/bin:$PATH:$HOME/go/bin:$HOME/bin";
      CLICOLOR = "1";
      LANG = "en_US.UTF-8";

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
      [[ $(HISTTIMEFORMAT="" builtin history 1) =~ [[:digit:]]+ ]]
      __fzy_history__() {
        ch="$(fc -rl 1 | ${awk} -F'\t' '{print $2}' | ${awk} '{!seen[$0]++};END{for(i in seen) if(seen[i]==1)print i}' | ${fzy})"
        ch="$(echo "$ch" | ${awk} '{$1=$1;print}')"
        READLINE_LINE=''${ch#*$'\t'}
        if [[ -z "$READLINE_POINT" ]]; then
          echo "$READLINE_LINE"
        else
          READLINE_POINT=0x7fffffff
        fi
      }

      bind -m emacs-standard -x '"\C-r": __fzy_history__'

      complete -cf doas

      if command -v kubectl &> /dev/null; then
        source <(kubectl completion bash)
        complete -F __start_kubectl k
      fi
    '';

  };
}
