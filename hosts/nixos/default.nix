{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./packages.nix
    ./../../nixos/drivers/amd-drivers.nix
  ];
  programs = {
    bash.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .#nixos";
    };
  };
  system.stateVersion = "24.11";
}
