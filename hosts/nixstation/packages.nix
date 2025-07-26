{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprlock
    fuzzel
    ashell
    gnome-characters
    libnotify
    handbrake

    # [shell] // zsh xonsh elvish ion fish powershell
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
    yad zenity
    chafa timg # terminal graphics library

    # amfora
    # appimage-run usbutils
    # v4l-utils
    # nwg-displays
    # lm_sensors
    # gnome-maps
    # gnome-clocks
  ];
}
