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
    extraConfig = {
      commit.verbose = true;
      init.defaultBranch = "master";
      pull.rebase = "true";
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";

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
