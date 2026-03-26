{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fuzzel
    swww # wallpaper
    hypridle # idling daemon

    quickshell
    # go          # For building DMS components
    # cava        # Audio visualization
    # cliphist    # Clipboard history
    # ddcutil
    # qt6.qtmultimedia
    # accountsservice
    # matugen     # Dynamic theming
    # gpu-screen-recorder
    # wlsunset
    # xdg-desktop-portal
    # evolution-data-server
    # app2unit
    # lm-sensors
    # swappy
    # aubio
    # libqalculate
    # kdePackages.kcolorchooser

    # notification client [libnotify]
    # character menu [gnome-characters]
    # volume control [pavucontrol, playerctl]
    # screen-locking-utility [hyprlock]
    # ags/eww # widget system [statusbar, application-launcher, calender, notifications]
    # [waybar, rofi, swaynotificationcenter, networkmanagerapplet, wlogout, swappy]
    # yad zenity amfora appimage-run usbutils v4l-utils nwg-displays gnome-maps gnome-clocks
  ];

  fonts.packages = with pkgs; [
    # material-symbols
    # inter

    (pkgs.fetchzip {
      url = "https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip"; # Latest as of Oct 2025
      sha256 = "sha256-GpbcLkSQb000WCeBLKaXPy07kaCOHEcqshTIbBdOzQc=";
      stripRoot = false;
      postFetch = ''
        mkdir -p $out/share/fonts/truetype
        mv $out/*.ttf $out/share/fonts/truetype/
      '';
    })
    (pkgs.fetchzip {
      url = "https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip"; # Use latest stable release
      sha256 = "sha256-Y2TZroei/NksZ4QS0H/dI18a5eiFH/LHueVgYgc9TeQ=";
      stripRoot = false;
      postFetch = ''
        mkdir -p $out/share/fonts/truetype
        mv $out/ttf/*.ttf $out/share/fonts/truetype/
      '';
    })
  ];

  # Enable fonts and refresh cache on rebuild
  fonts.fontconfig.enable = true;

  # Enabling session idling (hypridle)
  systemd.user.services.hypridle = {
    enable = true;
    description = "Hyprland's idle daemon";
    documentation = [ "https://wiki.hyprland.org/Hypr-Ecosystem/hypridle" ];
    wantedBy = [ "hyprland-session.target" ];
    partOf = [ "hyprland-session.target" ];
    after = [ "hyprland-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
      Restart = "on-failure";
      # ConditionEnvironment = "WAYLAND_DISPLAY";
    };
  };

  # Enabling wallpaper daemon (swww-daemon)
  systemd.user.services."swww-daemon" = {
    enable = true;
    description = "Wallpaper daemon";
    wantedBy = [ "hyprland-session.target" ];
    partOf = [ "hyprland-session.target" ];
    after = [ "hyprland-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
      # ConditionEnvironment = "WAYLAND_DISPLAY";
    };
  };
}
