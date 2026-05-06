{ ... }:

{
  imports = [ 
    ./boot.nix
    ./monitoring.nix
    ./programs.nix
    ./sound.nix
    ./user.nix
    ./utilities.nix
    ./wayland.nix

    ./development
    ./devices
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.polkit.enable = true;
  services.udisks2.enable = true;
  systemd.oomd.enable = false;
  systemd.services.systemd-machined.enable = false;
}
