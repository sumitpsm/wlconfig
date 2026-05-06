{ config, ... }:

{
  imports = [
    ./hardware.nix
    ./packages.nix
    # ./offsec
    ./../../modules/drivers/amd-drivers.nix
  ];
  system.stateVersion = "25.05";

  services.kmonad = {
    enable = true;
    keyboards = {
      myKMonadOutput = {
        device = "/dev/input/by-path/pci-0000:01:00.0-usbv2-0:5:1.0-event-kbd";
        config = builtins.readFile ./colemaxx.kbd;
      };
    };
  };

  # [CUSTOM OPTIONS]
  # user = {
  #   name = "sumit";
  #   description = "SumitModak";
  #   timeZone = "Asia/Kolkata";
  #   locale = "en_IN";
  #   kbdLayout = "us";
  # };
  # printing.enable = false;
  # autoCleanup.enable = false;

  # fileSystems."/run/media/${config.user.name}/MYFILES" = {
  #   device = "/dev/disk/by-uuid/8518-E3D5";
  #   fsType = "ext4";
  #   options = [ "nofail" ];
  # };
}
