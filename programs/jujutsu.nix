{ config
, pkgs
, ...
}:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Anirudh Oppiliappan";
        email = "x@icyphox.sh";
      };
      ui.paginate = "never";
    };
  };
}
