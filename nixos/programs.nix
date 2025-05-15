{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      kitty brave obs-studio gimp
      gnome-boxes wireshark
      gnome-characters gnome-calculator
      # calls gnome-maps handbrake gnome-clocks

      nautilus loupe mpv papers

      # pipes cmatrix
      # burpsuite
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
