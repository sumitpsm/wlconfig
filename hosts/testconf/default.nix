{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./packages.nix
    ./../../nixos/drivers/amd-drivers.nix
    ./../../nixos/mtp.nix
  ];
  programs = {
    bash.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .#testconf";
    };
  };
}
