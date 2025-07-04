{ pkgs, ... }:

{
  # services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    hyprlock
    grim
    slurp
    fuzzel
    ashell
    gnome-characters
    libnotify
    handbrake

    # [system-monitor] // htop bpytop glances iotop dool
    # [system-monitor-gui] // gnome-system-monitor cpu-x
    # [disk-usage] // dua duf baobab ncdu dust
    # [screensaver] // cmatrix pipes pipes-rs figlet cowsay asciinema asciinema-agg
    # [fetch] // fastfetch inxi neofetch freshfetch
    # [music-player] // termusic rmpc ncmpcpp cmus kew
    # [web-music-client] // ytermusic ncspot yui-music youtube-tui
    # [file-manager] // kdePackages.dolphin xfce.thunar
    # [disk-manager] // gparted kdePackages.partitionmanager mmtui
    # [browser] // firefox chromium torbrowser *opera
    # [theme-picker] // nwg-look libsForQt5.qt5ct
    # [video-editor] // kdePackages.kdenlive openshot-qt flowblade shotcut audacity *lightworks *davinci-resolve
    # [document] // libreoffice *wps
    # [misc] // youtube-music *discord *spotify

    mpv # celluloid kdePackages.dragon
    loupe eog
    papers
    yad
    gh
    wiki-tui
    cht-sh
    mprocs
    presenterm
    calls

    # amfora
    # appimage-run usbutils
    # socat
    # v4l-utils
    # nwg-displays
    # lm_sensors
    # gnome-maps
    # gnome-clocks
  ];
  programs = {
    bash.shellAliases = {
      kmap = "eval $(sudo kmonad -linfo ~/dev/colemaxx.kbd)";
    };
  };
}
