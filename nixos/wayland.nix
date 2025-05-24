{ config, pkgs, ... }:

let
  TuiGreetTheme = "\"border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=grey;input=red\"";
  NotwaitaBlackCursorTheme = builtins.fetchTarball {
    url = "https://github.com/ful1e5/notwaita-cursor/releases/download/v1.0.0-alpha1/Notwaita-Black.tar.xz";
    sha256 = "0byiix6pda7ibjpc1an1lrnm19prjmqx1q72ipx5q7dijw5z9fk4";
  };
in
{
  # TUI login manager (greetd.tuigreet)
  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --theme ${TuiGreetTheme} --cmd Hyprland";
      };
    };
  };

  # Wayland Compositor (hyprland)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "hyprland" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };

  systemd.user.services."xdg-document-portal".enable = false;
  systemd.user.services."xdg-permission-store".enable = false;

  # Enabling sound
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

  environment.systemPackages = with pkgs; [
    kmonad # keyboard mapper
    kitty # terminal emulator
    wl-clipboard # clipboard
    brightnessctl
    swww # wallpaper
    wallust # theme generator
    hypridle # idling daemon
    polkit_gnome # polkit agent

    # themes
    gnome-themes-extra
    adwaita-qt
    adwaita-icon-theme
    (pkgs.runCommand "Notwaita-Black" {} ''
      mkdir -p $out/share/icons
      ln -s ${NotwaitaBlackCursorTheme} $out/share/icons/Notwaita-Black
    '') # hyprcursor theme

    libnotify # notification client
    gnome-characters # character menu
    # pavucontrol, playerctl
    # screen-locking-utility [hyprlock]
    # ags/eww # widget system [statusbar, application-launcher, calender, notifications]
    # screen-shotting-tool & color-picker
    # waybar, rofi, swaynotificationcenter, networkmanagerapplet, wlogout, swappy, grim/slurp
    # imagemagick
  ];
}
