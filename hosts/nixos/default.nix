{ ... }:

{
  imports = [
    ./hardware.nix
    ./packages.nix
    ./../../modules/drivers/amd-drivers.nix
  ];
  system.stateVersion = "24.11";
}
