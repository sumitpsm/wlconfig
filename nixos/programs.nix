{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      kitty # terminal emulator
      brave # web browser
      obs-studio # screen recorder
      gimp # image editor
      gnome-calculator # calculator
      gnome-boxes # virtual machine manager
      wireshark # network protocol analyzer
      # calls gnome-clocks

      nautilus loupe mpv papers

      # pipes cmatrix
      # burpsuite
      # discord
      # youtube-music spotify
      # libreoffice wps
      # handbrake
      # gnome-maps
      # steam
    ];
    variables = {
      TERMINAL = "kitty";
    };
  };

  programs = {
    firefox.enable = false;
    bash.shellAliases = {
      icat = "kitty +kitten icat";
      kmap = "sudo kmonad ~/dev/colemak-sumit.kbd";
    };
  };
}
