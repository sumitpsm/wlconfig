{ config, pkgs, ... }:

{
  imports = [
  ];
  environment.systemPackages = with pkgs; [
    hyprlock
    grim
    slurp
    fuzzel
    ashell
    pavucontrol
    nwg-look
    libsForQt5.qt5ct
    nushell
    yad
    cpu-x

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
