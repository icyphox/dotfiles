{ config
, pkgs
, ...
}:

{
  programs.git = {
    enable = true;
    ignores = [ ".envrc" ];
    userEmail = "x@icyphox.sh";
    userName = "Anirudh Oppiliappan";
    signing = {
      key = "8A93F96F78C5D4C4";
      signByDefault = true;
    };
    extraConfig = {
      commit.verbose = true;
      init.defaultBranch = "master";
      pull.rebase = "true";
    };
    includes = [
      {
        "path" = "~/code/upcloud/gitconfig";
        "condition" = "gitdir:~/code/upcloud/";
      }
    ];
  };
}
