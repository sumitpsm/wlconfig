{ config, pkgs, ... }:

let
  ytdlp-github = pkgs.yt-dlp.overrideAttrs (oldAttrs: {
    version = "2025.04.30";
    src = pkgs.fetchFromGitHub {
      owner = "yt-dlp";
      repo = "yt-dlp";
      rev = "2025.04.30";
      sha256 = "sha256-vsMWzZu+kxlxYT5Cq+diNApzE3Cg22Hg0j9eDKLowWI=";
    };
  });
in
{
  environment.systemPackages = with pkgs; [
    brave # web browser
    obs-studio # screen recorder
    gimp # image editor
    gnome-calculator # calculator
    gnome-boxes # virtual machine manager
    wireshark # network protocol analyzer
    nautilus # file manager
    gnome-disk-utility # disk manager
    
    # yt-dlp
    ffmpeg-full ytdlp-github
  ];
}
