{ ... }:

{
  imports = [
    ./hardware.nix
    ./packages.nix
    # ./offsec
    ./../../modules/drivers/amd-drivers.nix
  ];
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
