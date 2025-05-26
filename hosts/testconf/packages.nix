{ config, pkgs, ... }:

{
  # services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    hyprlock
    grim
    slurp
    fuzzel
    ashell
    pavucontrol
    gnome-characters
    libnotify

    nautilus # dolphin thunar
    mpv
    loupe # eog
    papers
    nwg-look
    libsForQt5.qt5ct
    yad
    nushell
    cpu-x
    gitui

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
