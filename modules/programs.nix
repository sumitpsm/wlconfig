{ pkgs, ... }:

let
  ytdlp-github = pkgs.yt-dlp.overrideAttrs (oldAttrs: {
    version = "2025.08.22";
    src = pkgs.fetchFromGitHub {
      owner = "yt-dlp";
      repo = "yt-dlp";
      rev = "2025.08.22";
      sha256 = "sha256-58Qj+Bt4GEGgWpqAuMVemixm5AUcqS+e2Sajoeun8KY=";
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
    tor-browser # tor network client

    # handbrake # video compressor
    kmonad # keyboard mapper
    playerctl
    firefox # browser that supports live streams
  ];
  # programs.calls.enable = true;
}
