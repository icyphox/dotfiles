{ pkgs, ... }:

let
  name = "record";
  slop = "${pkgs.slop}/bin/slop";
  ffmpeg = "${pkgs.ffmpeg}/bin/ffmpeg";
in
pkgs.writeScriptBin name
  ''
    echo starting recording ...
    coords=$(${slop} -f "%x %y %w %h %g %i") || exit 1
    read -r X Y W H G ID < <(echo $coords)
    ${ffmpeg} \
      -f x11grab \
      -s "$W"x"$H" \
      -i :0.0+$X,$Y  \
      -f alsa \
      -thread_queue_size 512 \
      -ac 2 \
      -ar 48000 \
      -i hw:0 \
      -framerate 60 \
      -vcodec libx264 \
      -threads 4 \
      -y \
      /home/icy/tmp/x.mkv

    ${ffmpeg} \
      -i /home/icy/tmp/x.mkv \
      -pix_fmt yuv420p \
      -vf scale=-2:1080 \
      "/home/icy/vids/rec/$1"
  ''
