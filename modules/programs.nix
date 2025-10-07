{ inputs, pkgs, ... }:

let
  ytdlp-github = pkgs.yt-dlp.overrideAttrs (oldAttrs: {
    version = "2025.09.26";
    src = pkgs.fetchFromGitHub {
      owner = "yt-dlp";
      repo = "yt-dlp";
      rev = "2025.09.26";
      sha256 = "sha256-/uzs87Vw+aDNfIJVLOx3C8RyZvWLqjggmnjrOvUX1Eg=";
    };
  });
in
{
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    ytdlp-github # video downloader // [parabolic]

    kitty alacritty # terminal emulators
    swayimg # image viewer
    zathura # document viewer
    mpv mpvScripts.mpris # video & audio player
    gnome-calculator # calculator
    gnome-disk-utility # disk manager
    obs-studio # screen recorder
    gimp3 # image editor // [inkscape krita]
    blender # 3d modelling system + video editor
    gnome-boxes # virtual machine manager

    (inputs.zen-browser.packages.${system}.beta.override {}) # zen browser
    # handbrake # video compressor
    kmonad # keyboard mapper
    playerctl
    firefox # browser that supports live streams
  ];
  # programs.calls.enable = true;
}
