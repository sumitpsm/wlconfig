{ inputs, pkgs, ... }:

let
  ytdlp-github = pkgs.yt-dlp.overrideAttrs (oldAttrs: {
    version = "2025.11.12";
    src = pkgs.fetchFromGitHub {
      owner = "yt-dlp";
      repo = "yt-dlp";
      rev = "2025.11.12";
      sha256 = "sha256-Em8FLcCizSfvucg+KPuJyhFZ5MJ8STTjSpqaTD5xeKI=";
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

    (inputs.zen-browser.packages.${stdenv.hostPlatform.system}.beta.override {}) # zen browser
    # handbrake # video compressor
    # kmonad # keyboard mapper
  ];
  # programs.calls.enable = true;
}
