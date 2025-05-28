{ config, pkgs, ... }:

{
  # services.xserver.desktopManager.gnome.enable = true;
  programs.hyprlock.enable = true;
  environment.systemPackages = with pkgs; [
    grim
    slurp
    fuzzel
    ashell
    pavucontrol
    gnome-characters
    libnotify

    gnome-disk-utility gparted
    nautilus kdePackages.dolphin xfce.thunar
    mpv
    loupe # eog
    papers
    nushell
    termusic ytermusic rmpc ncmpcpp cmus
    gitui
    cpu-x
    nwg-look
    libsForQt5.qt5ct
    yad

    # games
    ninvaders
    nsnake
    bastet
    greed
    nethack
    cataclysm-dda
    shattered-pixel-dungeon
    _2048-cli
    blightmud

    nbsdgames

    # terminal
    cmatrix
    pipes
    pipes-rs
    figlet
    cowsay

    # duf baobab ncdu 
    # htop gnome-system-monitor
    # fastfetch inxi neofetch
    # pipes cmatrix
    # lshw cpu-x
    # firefox torbrowser
    # audacity
    # handbrake
    # amfora
    # appimage-run usbutils
    # socat
    # v4l-utils
    # gh
    # nwg-displays
    # gnome-maps
    # steam
    # calls
    # lm_sensors
    # gnome-clocks
    # burpsuite
    # discord
    # youtube-music spotify
    # libreoffice wps
  ];
}
