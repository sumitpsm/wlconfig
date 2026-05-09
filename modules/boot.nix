{ ... }:

{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev"; # use "/dev/vda" for VMs
    useOSProber = true;
  };
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [
    "ext4" "xfs" "btrfs" "exfat" "vfat" "ntfs" # "zfs" "f2fs"
  ];
}
