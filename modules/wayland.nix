{ pkgs, ... }:

let
  NotwaitaBlackCursorTheme = builtins.fetchTarball {
    url = "https://github.com/ful1e5/notwaita-cursor/releases/download/v1.0.0-alpha1/Notwaita-Black.tar.xz";
    sha256 = "0byiix6pda7ibjpc1an1lrnm19prjmqx1q72ipx5q7dijw5z9fk4";
  };
in
{
  # Wayland Compositor (hyprland)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  systemd.user.targets.hyprland-session = {
    description = "Hyprland compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  # Enabling polkit agent (polkit-gnome-authentication-agent-1)
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    enable = true;
    description = "PolicyKit Gnome Authentication Agent";
    wantedBy = [ "hyprland-session.target" ];
    wants = [ "hyprland-session.target" ];
    after = [ "hyprland-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
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
        # "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };
  systemd.user.services."xdg-document-portal".enable = false;
  systemd.user.services."xdg-permission-store".enable = false;

  environment.systemPackages = with pkgs; [
    kitty alacritty # terminal emulators
    wl-clipboard # clipboard
    polkit_gnome # polkit agent
    grim slurp hyprpicker

    # themes
    gnome-themes-extra
    adwaita-qt
    adwaita-icon-theme
    (pkgs.runCommand "Notwaita-Black" {} ''
      mkdir -p $out/share/icons
      ln -s ${NotwaitaBlackCursorTheme} $out/share/icons/Notwaita-Black
    '') # hyprcursor theme
  ];

  # Enable fonts and refresh cache on rebuild
  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.dejavu-sans-mono
  ];

  programs.dconf = {
    enable = true;
    profiles.user.databases = [{
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita-dark";
          icon-theme = "Adwaita";
          cursor-theme = "Notwaita-Black";
          cursor-size = "24";
        };
      };
    }];
  };
}
