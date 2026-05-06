{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    # handbrake
    imagemagick
    yt-dlp
  ];
}
