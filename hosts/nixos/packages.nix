{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fuzzel
    awww # wallpaper
    hypridle # idling daemon

    quickshell
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

  # Enabling wallpaper daemon (awww-daemon)
  systemd.user.services."awww-daemon" = {
    enable = true;
    description = "Wallpaper daemon";
    wantedBy = [ "hyprland-session.target" ];
    partOf = [ "hyprland-session.target" ];
    after = [ "hyprland-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.awww}/bin/awww-daemon";
      Restart = "on-failure";
      # ConditionEnvironment = "WAYLAND_DISPLAY";
    };
  };
}
