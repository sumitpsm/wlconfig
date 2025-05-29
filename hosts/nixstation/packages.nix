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

    gh rsync
    nushell fish
    gitui lazygit
    termusic rmpc ncmpcpp cmus
    # [fetch] // fastfetch, inxi, neofetch, freshfetch,
    # [system-monitor] // htop, gnome-system-monitor,
    # [file-manager] // kdePackages.dolphin, xfce.thunar,
    # [disk-manager] // gparted, kdePackages.partitionmanager, mmtui,
    # [browser] // firefox, chromium, torbrowser, *opera,
    # [theme-picker] // nwg-look, libsForQt5.qt5ct,
    duf baobab ncdu
    metasploit mtr
    mpv celluloid kdePackages.dragon
    loupe eog
    papers
    parabolic
    ytermusic
    yad

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

    # terminal
    cmatrix pipes pipes-rs figlet cowsay
  ];
}
