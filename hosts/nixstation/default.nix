{ ... }:

{
  imports = [
    ./hardware.nix
    ./packages.nix
    # ./network.nix
    ./../../modules/drivers/amd-drivers.nix
  ];
  programs = {
    bash.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .#nixstation";
    };
  };
  system.stateVersion = "25.05";

  # [CUSTOM OPTIONS]
  # user = {
  #   name = "sumit";
  #   description = "SumitModak";
  #   timeZone = "Asia/Kolkata";
  #   locale = "en_IN";
  #   kbdLayout = "us";
  # };
  # laptop.enable = false;
  # printing.enable = false;
  # autoCleanup.enable = false;
}
