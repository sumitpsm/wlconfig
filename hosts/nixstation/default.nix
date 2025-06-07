{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./packages.nix
    ./../../modules/drivers/amd-drivers.nix
  ];
  programs = {
    bash.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .#nixstation";
    };
  };
  system.stateVersion = "25.05";

  # custom options
  # user = {
  #   name = "sumit";
  #   description = "SumitModak";
  #   timeZone = "Asia/Kolkata";
  #   locale = "en_IN";
  #   kbdLayout = "us";
  # };
  # autoCleanup.enable = false;
  # printing.enable = false;
}
