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
    ./scripts
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # nix.package = pkgs.nixVersions.nix_2_30;

  virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;
  users.users.${config.user.name}.extraGroups = [
    "libvirtd" # for virtualization
  ];

  # enables the polkit service
  security.polkit.enable = true;

  users.users.root = {
    shell = pkgs.nushell;
  };
}
