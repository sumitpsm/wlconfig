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
    kitty alacritty # terminal emulators
    kmonad # keyboard mapper
    swayimg # image viewer
    zathura # document viewer
    mpv # video & audio player
    gnome-calculator # calculator
    gnome-disk-utility # disk manager
    obs-studio # screen recorder
    gimp # image editor
    gnome-boxes # virtual machine manager
    tor-browser # tor network client
    # blender # 3d modelling system

    kdePackages.kdenlive handbrake # video editor
    grim slurp hyprpicker kdePackages.kcolorchooser # screenshot + color picker
    firefox
    
    # yt-dlp
    ffmpeg-full ytdlp-github # parabolic // for GUI
  ];
  # programs.calls.enable = true;
}
