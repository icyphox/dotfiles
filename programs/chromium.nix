{ config
, pkgs
, ...
}:

{
  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "aapbdbdomjkkjkaonfhkkikfgjllcleb" # translate
      "aghfnjkcakhmadgdomlmlhhaocbkloab" # just black
      "pobhoodpcipjmedfenaigbeloiidbflp" # minimal twitter
      "ennpfpdlaclocpomkiablnmbppdnlhoh" # rust search extension
    ];
  };
}
