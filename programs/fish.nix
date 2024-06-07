{ config
, pkgs
, ...
}:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    functions = {
      fish_prompt = ''
        printf '\n\001\002▲\001\002 '
      '';
      ggp = ''
        if test "$argv[1]" = "-f"
            git push (git remote show) -f (git branch --show-current)
        else
            git push (git remote show) (git branch --show-current)
        end
      '';

      gpl = ''
        if test -n "$argv[1]"
            set branch $argv[1]
        else
            set branch (git branch --show-current)
        end
        git pull -r (git remote show) $branch
      '';

      gco = ''
        if test -z "$argv[1]"
            return 1
        end

        git rev-parse --verify $argv[1] > /dev/null 2>&1
        if test $status -eq 0
            git checkout $argv[1]
        else
            git checkout -b $argv[1]
        end
      '';
    };
    shellAbbrs = {
      gc = "git commit -v -S";
      gst = "git status --short";
      ga = "git add";
      gd = "git diff --minimal";
      gl = "git log --oneline --decorate --graph";
      k = "kubectl";
    };
    shellAliases = {
      n = "z";
      "..." = "cd ../..";
    };
  };
}
