{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # hyprlock
    fuzzel
    # ashell
    gnome-characters
    # libnotify
    grim slurp hyprpicker kdePackages.kcolorchooser

    quickshell  # Required for QML runtime
    go          # For building DMS components
    cava        # Audio visualization
    cliphist    # Clipboard history
    ddcutil
    qt6.qtmultimedia
    accountsservice
    matugen     # Dynamic theming
    gpu-screen-recorder
    wlsunset
    xdg-desktop-portal
    evolution-data-server
    app2unit
    # lm-sensors
    swappy
    aubio
    libqalculate

    # [shell] // dash bash zsh xonsh elvish ion fish powershell
    # [terminal-multiplexer] // mprocs tmux
    # [system-monitor] // htop bpytop glances iotop dool zenith sysstat
    # [system-monitor-gui] // gnome-system-monitor cpu-x
    # [disk-usage] // dua duf baobab ncdu dust dysk
    # [screensaver] // cmatrix pipes pipes-rs figlet cowsay
    # [fetch] // fastfetch inxi neofetch freshfetch
    # [music-player] // termusic rmpc ncmpcpp cmus kew
    # [git-tuis] // lazygit gitui tig ungit
    # [web-music-client] // ytermusic ncspot yui-music youtube-tui
    # [documentation] // wiki-tui cht-sh
    # [theme-generator] // wallust pywal pywal16
    # [terminal-graphics] // chafa timg
    # [document-viewer] // papers
    # [image-viewer] // loupe eog nomacs imv
    # [video-player] // celluloid kdePackages.dragon
    # [file-manager] // nautilus kdePackages.dolphin xfce.thunar
    # [disk-manager] // gparted kdePackages.partitionmanager mmtui gnome-disk-utility
    # [browser] // firefox chromium torbrowser *opera
    # [theme-picker] // nwg-look libsForQt5.qt5ct
    # [video-editor] // kdePackages.kdenlive openshot-qt flowblade shotcut audacity *lightworks *davinci-resolve
    # [document] // libreoffice *wps
    # [misc] // youtube-music *discord *spotify
    # [yt-dlp-frontend] // parabolic video-downloader

    # yad zenity amfora appimage-run usbutils v4l-utils nwg-displays lm_sensors gnome-maps gnome-clocks
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
}
