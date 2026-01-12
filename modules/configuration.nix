{ config, pkgs, ... }:

{
  imports = [ 
    ./boot.nix
    ./user.nix
    ./dev.nix
    ./networking.nix
    ./sound.nix
    ./usb.nix
    ./wayland.nix
    ./programs.nix

    ./fonts.nix
    ./services
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;

  users.users.${config.user.name}.extraGroups = [
    "libvirtd" # for virtualization
    "wheel" # for sudo privileges
  ];

  security.polkit.enable = true;

  users.users.root = {
    shell = pkgs.nushell;
  };
}
