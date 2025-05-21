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

      nautilus # dolphin thunar
      mpv
      loupe # eog
      papers
      # duf baobab ncdu
      # btop htop gnome-system-monitor
      # fastfetch inxi neofetch
      # lshw cpu-x
      # pipes cmatrix
      # greetd.tuigreet
      # amfora
      # appimage-run
      # socat
      # usbutils
      # v4l-utils
      # gh
      # nwg-displays
      # handbrake
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
