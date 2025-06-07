{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./packages.nix
    ./../../modules/drivers/amd-drivers.nix
  ];
  programs = {
    bash.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .#nixos";
    };
  };
  system.stateVersion = "24.11";
}
