{ config
, lib
, pkgs
, ...
}:

{
  accounts.email.maildirBasePath = "mail";
  accounts.email.accounts."x@icyphox.sh" = {
    address = "x@icyphox.sh";
    imap = {
      host = "imap.migadu.com";
      port = 993;
    };
    maildir = {
      path = "personal";
    };
    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "maildir";
    };
    primary = true;
    passwordCommand = "${pkgs.gnupg}/bin/gpg -q --for-your-eyes-only --no-tty -d /home/icy/.pw/default.gpg";
    realName = "Anirudh Oppiliappan";
    userName = "x@icyphox.sh";
    signature = {
      text = ''

        -- 
        Anirudh Oppiliappan
        https://icyphox.sh
      '';
    };
  };
}

