{ config
, pkgs
, ...
}:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        serverAliveInterval = 180;
        serverAliveCountMax = 3;
        identityFile = [ "~/.ssh/id_ed25519" ];
      };
      "github.com" = {
        user = "git";
        hostname = "github.com";
      };
    };
  };
}
