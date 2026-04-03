{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    # handbrake
    imagemagick
    zip
    unzip
    p7zip
    yt-dlp
  ];
}
