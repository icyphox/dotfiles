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
