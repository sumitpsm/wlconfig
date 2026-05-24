{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wldash # app launcher
    awww # wallpaper
    swaylock # screen lock
    swayidle # idling daemon
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
