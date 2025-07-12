{ pkgs, ... }:

let
  ytdlp-github = pkgs.yt-dlp.overrideAttrs (oldAttrs: {
    version = "2025.06.30";
    src = pkgs.fetchFromGitHub {
      owner = "yt-dlp";
      repo = "yt-dlp";
      rev = "2025.06.30";
      sha256 = "sha256-dwBe6oXh7G67kfiI6BqiC0ZHzleR7QlfMiTVXWYW85I=";
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
    nautilus # file manager
    gnome-disk-utility # disk manager
    
    # yt-dlp
    ffmpeg-full ytdlp-github # parabolic // for GUI
  ];
  # programs.calls.enable = true;
}
