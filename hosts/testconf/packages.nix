{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    fuzzel
    ashell
    pavucontrol
    nwg-look
    libsForQt5.qt5ct
    nushell
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
  ];
}
