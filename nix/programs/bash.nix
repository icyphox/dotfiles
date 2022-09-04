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
      PW_DIR = "$HOME/.pw";
      PW_KEY = "x@icyphox.sh";
      PATH = "$PATH:$HOME/go/bin:$HOME/bin";

    };

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

      for i in ~/.bashrc.d/[0-9]*; do
          . "$i"
      done
    '';

  };
}
