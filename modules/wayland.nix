{ inputs, pkgs, ... }:

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
    withUWSM = false;
  };

  environment.systemPackages = with pkgs; [
    kitty alacritty # terminal emulators // [ghostty foot wezterm]
    wl-clipboard # clipboard
    wl-screenrec # screen recorder // [obs-studio obs-cli]
    grim slurp # screenshot
    hyprpicker # color picker
    mpv mpvScripts.mpris # video & audio player
    # image editor // [gimp3 inkscape krita graphite]
    # video editor // [kdenlive]
    # 3d modelling system + // [blender]
    papers # document viewer
    polkit_gnome # polkit agent
    (inputs.zen-browser.packages.${stdenv.hostPlatform.system}.beta.override {}) # browser

    # themes
    gnome-themes-extra
    adwaita-qt
    adwaita-icon-theme
    (pkgs.runCommand "Notwaita-Black" {} ''
      mkdir -p $out/share/icons
      ln -s ${NotwaitaBlackCursorTheme} $out/share/icons/Notwaita-Black
    '') # hyprcursor theme
  ];

  programs.virt-manager.enable = true;

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

  # Enabling polkit agent (polkit-gnome-authentication-agent-1)
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    enable = true;
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

  # Enable fonts and refresh cache on rebuild
  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.dejavu-sans-mono
  ];
}
