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
      };
      "github.com" = {
        user = "git";
        hostname = "github.com";
        identityFile = [ "~/.ssh/id_ed25519" "~/.ssh/upcloud" ];
      };
      "fern" = {
        user = "ubuntu";
        hostname = "fern";
        identityFile = "~/.ssh/id_rsa";
      };
      "egg" = {
        user = "icy";
        hostname = "egg";
        identityFile = [ "~/.ssh/id_ed25519" "~/.ssh/upcloud" ];
      };
      "upcloud" = {
        hostname = "git.services.upcloud.com";
        identityFile = "~/.ssh/upcloud";
      };
      "denna" = {
        hostname = "denna";
        identityFile = [ "~/.ssh/id_ed25519" "~/.ssh/upcloud" ];
      };
      "jade" = {
        user = "ubuntu";
        hostname = "jade";
        identityFile = "~/.ssh/id_rsa";
      };
      "lapis2" = {
        user = "icy";
        hostname = "150.230.131.193";
        identityFile = "~/.ssh/id_rsa";
      };
      "aniverse" = {
        user = "icy";
        hostname = "94.237.18.93";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
