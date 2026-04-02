{ config, ... }:

{
  imports = [ 
    ./boot.nix
    ./user.nix
    ./dev.nix
    ./networking.nix
    ./sound.nix
    ./wayland.nix
    ./programs.nix

    ./services
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.${config.user.name}.extraGroups = ["wheel"]; # for sudo privileges

  security.polkit.enable = true;
  services.udisks2.enable = true;
  # services.udev.enable = true;
}
