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
    zathura # document viewer
    mpv mpvScripts.mpris # video & audio player
    gnome-boxes # virtual machine manager
    gnome-calculator # calculator
    obs-studio # screen recorder
    gimp3 # image editor // [inkscape krita]
    blender # 3d modelling system + video editor

    (inputs.zen-browser.packages.${stdenv.hostPlatform.system}.beta.override {}) # zen browser
    # diagram editor // [drawy, rnote]
    # handbrake # video compressor
    # kmonad # keyboard mapper
  ];
  # programs.calls.enable = true;
}
