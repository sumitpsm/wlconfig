{ config, ... }:

{
  imports = [ 
    ./boot.nix
    ./inspect.nix
    ./programs.nix
    ./sound.nix
    ./user.nix
    ./wayland.nix

    ./development
    ./services
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.${config.user.name}.extraGroups = ["wheel"]; # for sudo privileges

  security.polkit.enable = true;
  services.udisks2.enable = true;
  systemd.oomd.enable = false;
  systemd.services.systemd-machined.enable = false;
}
