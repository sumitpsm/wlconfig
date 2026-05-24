{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wldash # app launcher
    awww # wallpaper
    swaylock # screen lock
    swayidle # idling daemon

    # gh tailwindcss_4 tailwindcss-language-server 
    # quickshell
    # go          # For building DMS components
    # cliphist    # Clipboard history
    # ddcutil
    # qt6.qtmultimedia
    # accountsservice
    # gpu-screen-recorder
    # evolution-data-server
    # app2unit
    # lm-sensors
    # aubio
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

  # programs.calls.enable = true;

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
