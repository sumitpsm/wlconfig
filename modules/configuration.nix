{ config, ... }:

{
  imports = [ 
    ./boot.nix
    ./user.nix
    ./dev.nix
    ./rust.nix
    ./networking.nix
    ./sound.nix
    ./usb.nix
    ./wayland.nix
    ./programs.nix

    ./fonts.nix
    ./services
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # enables the polkit service
  security.polkit.enable = true;

  virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;
  users.users.${config.user.name}.extraGroups = [
    "libvirtd" # for virtualization
  ];
}
