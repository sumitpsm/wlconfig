{ config, pkgs, ... }:

let
  NotwaitaBlackCursorTheme = builtins.fetchTarball {
    url = "https://github.com/ful1e5/notwaita-cursor/releases/download/v1.0.0-alpha1/Notwaita-Black.tar.xz";
    sha256 = "0byiix6pda7ibjpc1an1lrnm19prjmqx1q72ipx5q7dijw5z9fk4";
  };
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
  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # media-session.enable = true; # use the example session manager (no others are packaged yet so this is enabled by default)
    # jack.enable = true;
  };

  # wayland compositor
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      kmonad # keyboard mapper
      wl-clipboard # clipboard manager
      brightnessctl
      swww # wallpaper
      hypridle # idling utility
      wallust # theme
      polkit_gnome # polkit agent

      # hyprcursor-themes
      (pkgs.runCommand "Notwaita-Black" {} ''
        mkdir -p $out/share/icons
        ln -s ${NotwaitaBlackCursorTheme} $out/share/icons/Notwaita-Black
      '')

      # gtk-themes
      andromeda-gtk-theme
      # nordzy-icon-theme

      # yt-dlp
      ffmpeg ytdlp-github

      libnotify # notification client
      gnome-characters # character menu
      # pavucontrol, playerctl
      # screen-locking-utility [hyprlock]
      # ags/eww # widget system [statusbar, application-launcher, calender, notifications]
      # screen-shotting-tool & color-picker
      # waybar, rofi, swaynotificationcenter, networkmanagerapplet, wlogout, swappy, grim/slurp
      # imagemagick
    ];
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  services.hypridle.enable = true;

  services.xserver = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };
}
