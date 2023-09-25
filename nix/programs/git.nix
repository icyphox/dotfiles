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

      url."ssh://git@github.com/".insteadOf = "https://github.com/";
      url."ssh://git@git.services.upcloud.com/".insteadOf = "https://git.services.upcloud.com/";
    };
    includes = [
      {
        "path" = "~/code/upcloud/gitconfig";
        "condition" = "gitdir:~/code/upcloud/";
      }
    ];
  };
}
