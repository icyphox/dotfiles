{ pkgs, theme, host, ... }:

let

  # open a window with live video feed from the camera
  webcam = pkgs.writeScriptBin "webcam" ''
    ${pkgs.mpv}/bin/mpv av://v4l2:/dev/video0 --profile=low-latency --untimed
  '';

  # create new repo on git.icyphox.sh
  git-new-repo = pkgs.writeScriptBin "git-new-repo" ''
    repo="$1"
    [[ "$1" == "" ]] && repo="$(basename "$PWD")"
    ssh git@jade git init --bare "$repo"
    read -p "descripton: " desc
    printf '%s' "$desc" > .git/description
    rsync .git/description git@jade:"$repo"
  '';

  # adds a new push-only remote
  git-new-push-remote = pkgs.writeScriptBin "git-new-push-remote" ''
    [[ "$@" == "" ]] && {
      printf '%s\n' "usage: git new-push-remote <remote url>"
      exit
    }

    old_push_remote="$(git remote -v | grep '(push)' | awk '{print $2}')"
    git remote set-url "$(git remote show)" --add --push "$1"
    git remote set-url "$(git remote show)" --add --push "$old_push_remote"
  '';

  # json pretty
  jp = pkgs.writeScriptBin "jp" ''
    ${pkgs.coreutils}/bin/cat | ${pkgs.jq}/bin/jq "$@"
  '';

  # screen record with ffmpeg and slop
  record = import ./record.nix pkgs;

  # bar
  bar = import ./bar.nix { inherit pkgs theme host; };

  # xurls
  xurls = import ./xurls.nix pkgs;

  # file uploader
  # uploader = import ./up.nix pkgs;

  # battery script
  battery = import ./battery.nix pkgs;
in
[
  git-new-push-remote
  git-new-repo
  jp
  webcam
  record
  battery
  bar
  xurls
]
