{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./packages.nix
    ./../../nixos/drivers/amd-drivers.nix
  ];
}
