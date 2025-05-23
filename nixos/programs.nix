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

    # yt-dlp
    ffmpeg ytdlp-github

    nautilus # dolphin thunar
    mpv
    loupe # eog
    papers
    # duf baobab ncdu
    # btop htop gnome-system-monitor
    # fastfetch inxi neofetch
    # lshw cpu-x
    # pipes cmatrix
    # greetd.tuigreet
    # amfora
    # appimage-run
    # socat
    # usbutils
    # v4l-utils
    # gh
    # nwg-displays
    # handbrake
    # gnome-maps
    # steam
    # calls
    # lm_sensors
    # gnome-clocks
    # burpsuite
    # discord
    # youtube-music spotify
    # libreoffice wps
  ];

  programs = {
    bash.shellAliases = {
      kmap = "sudo kmonad ~/dev/colemak-sumit.kbd";
    };
  };
}
