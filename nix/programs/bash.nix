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
      # Ctrl+W kills word
      stty werase undef

      # fzy reverse search
      __fzy_history() {
          ch="$(fc -rl 1 | awk -F'\t' '{print $2}' | sort -u | fzy)"
          : "''${ch#"''${ch%%[![:space:]]*}"}"
          printf "$_"
      }

      bind -x '"\C-r": READLINE_LINE=$(__fzy_history); READLINE_POINT="''${#READLINE_LINE}"'

      complete -cf doas
      complete -F __start_kubectl k
    '';

  };
}
