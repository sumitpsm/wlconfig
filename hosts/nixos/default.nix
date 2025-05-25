{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./packages.nix
  ];
}
