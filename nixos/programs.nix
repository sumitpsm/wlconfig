{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      kitty brave obs-studio gimp gnome-characters
      nautilus loupe mpv papers
      gnome-boxes wireshark
      # calls gnome-maps handbrake gnome-clocks

      # pipes cmatrix
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
