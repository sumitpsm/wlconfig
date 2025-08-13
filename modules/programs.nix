{ pkgs, ... }:

let
  ytdlp-github = pkgs.yt-dlp.overrideAttrs (oldAttrs: {
    version = "2025.08.11";
    src = pkgs.fetchFromGitHub {
      owner = "yt-dlp";
      repo = "yt-dlp";
      rev = "2025.08.11";
      sha256 = "sha256-j7x844MPPFdXYTJiiMnru3CE79A/6JdfJDdh8it9KsU=";
    };
  });
in
{
  environment.systemPackages = with pkgs; [
    alacritty kitty # terminal emulators
    kmonad # keyboard mapper
    brave # web browser
    obs-studio # screen recorder
    gimp # image editor
    gnome-calculator # calculator
    gnome-boxes # virtual machine manager
    nautilus # file manager
    gnome-disk-utility # disk manager
    grim slurp hyprpicker kdePackages.kcolorchooser # screenshot + color picker
    
    # yt-dlp
    ffmpeg-full ytdlp-github # parabolic // for GUI
  ];
  # programs.calls.enable = true;
}
