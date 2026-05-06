{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fuzzel
    awww # wallpaper
    hypridle # idling daemon

    quickshell
    # gh tailwindcss_4 tailwindcss-language-server 
    # go          # For building DMS components
    # cava        # Audio visualization
    # cliphist    # Clipboard history
    # ddcutil
    # qt6.qtmultimedia
    # accountsservice
    # gpu-screen-recorder
    # wlsunset
    # xdg-desktop-portal
    # evolution-data-server
    # app2unit
    # lm-sensors
    # aubio
    # libqalculate
    # kdePackages.kcolorchooser
    # yad zenity amfora appimage-run usbutils v4l-utils nwg-displays gnome-maps gnome-clocks

    # [shell] // dash bash zsh xonsh elvish ion fish powershell
    # [terminal-multiplexer] // mprocs tmux
    # [git-tuis] // lazygit gitui tig ungit
    # [music-player-tui] // termusic rmpc ncmpcpp cmus kew
    # [terminal-presentation] // asciinema asciinema-agg presenterm
    # [screensaver] // cmatrix pipes pipes-rs figlet cowsay
    # [fetch] // fastfetch inxi neofetch freshfetch
    # [documentation] // wiki-tui cht-sh
    # [terminal-graphics] // chafa timg
    # [theme-generator] // wallust pywal pywal16 matugen
    # [network-monitor] // termshark sniffnet bandwhich nethogs netscanner netwatch-tui
    # [system-monitor-tui] // htop bpytop glances iotop dool zenith sysstat sysdig
    # [system-monitor-gui] // gnome-system-monitor cpu-x
    # [disk-usage] // dua duf baobab ncdu dust dysk
    # [web-music-client] // ytermusic ncspot yui-music youtube-tui
    # [calculator] // gnome-calculator libqalculate
    # [diagram-editor] // drawy rnote excalidraw tldraw
    # [document-viewer] // papers evince atril qpdfview zathura koreader kdePackages.okular -- foliate mupdf 
    # [markdown-viewer] // ghostwriter retext vivify kdePackages.okular -- inlyne litemdview
    # [image-viewer] // loupe eog nomacs imv
    # [video-player] // celluloid kdePackages.dragon
    # [file-manager] // nautilus kdePackages.dolphin xfce.thunar
    # [disk-manager] // gparted kdePackages.partitionmanager mmtui gnome-disk-utility
    # [browser] // firefox chromium tor-browser *opera
    # [theme-picker] // nwg-look libsForQt5.qt5ct
    # [video-editor] // kdePackages.kdenlive openshot-qt flowblade shotcut audacity *lightworks *davinci-resolve
    # [document] // libreoffice *wps
    # [misc] // youtube-music *discord *spotify
    # [yt-dlp-frontend] // parabolic video-downloader
    # [web-intercepter] // zap *burpsuite
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
