{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    imagemagick
    ffmpeg-full
    # handbrake
    yt-dlp
  ];
}
