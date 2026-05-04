{ ... }:

{
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/vda";
  # boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "usb_storage" "exfat" "vfat"];
  boot.supportedFilesystems = [
    "ext4" "xfs" "btrfs" "exfat" "fat32" "ntfs" # "zfs" "f2fs" "vfat"
  ];
}
