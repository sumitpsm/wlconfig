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

    nushell fish
    termusic rmpc ncmpcpp cmus
    gitui lazygit
    # [fetch] // fastfetch, inxi, neofetch, freshfetch,
    # [system-monitor] // htop, gnome-system-monitor,
    # [file-manager] // kdePackages.dolphin, xfce.thunar,
    # [disk-manager] // gparted, kdePackages.partitionmanager,
    # [browser] // firefox, chromium, torbrowser, *opera,
    duf baobab ncdu mmtui
    metasploit mtr
    mpv celluloid kdePackages.dragon
    loupe eog
    papers
    parabolic
    ytermusic
    nwg-look libsForQt5.qt5ct
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
    gnome-chess

    # terminal
    cmatrix
    pipes
    pipes-rs
    figlet
    cowsay

    # lshw cpu-x
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
