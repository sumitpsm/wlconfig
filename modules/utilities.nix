{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # imagemagick
    ffmpeg-full
    # handbrake
    yt-dlp
    # gzip
    # xz
    # bzip2
    # zstd
    # p7zip
  ];
}
