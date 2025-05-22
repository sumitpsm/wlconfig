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
  # TUI login manager (greetd.tuigreet)
  services.greetd = {
    enable = true;
    vt = 1;
    settings = {
      default_session = {
        user = "sumit";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      };
    };
  };

  # Wayland Compositor (hyprland)
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
  };

  # Enabling session idling (hypridle)
  systemd.user.services.hypridle = {
    description = "Hyprland's idle daemon";
    documentation = [ "https://wiki.hyprland.org/Hypr-Ecosystem/hypridle" ];
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
      Restart = "on-failure";
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
  };

  # Enabling polkit agent (polkit-gnome-authentication-agent-1)
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "PolicyKit Gnome Authentication Agent";
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

  environment = {
    systemPackages = with pkgs; [
      kmonad # keyboard mapper
      wl-clipboard # clipboard manager
      brightnessctl
      swww # wallpaper
      wallust # theme

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

  services.xserver = {
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
