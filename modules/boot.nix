{ config, pkgs, ... }:

{
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/vda";
  # boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "usb_storage" "exfat" "vfat"];
  boot.supportedFilesystems = [
    "btrfs" "exfat" "ext4" "f2fs" "ntfs" "vfat" "xfs" # "zfs"
  ];
}
