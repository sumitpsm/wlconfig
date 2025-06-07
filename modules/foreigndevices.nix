{ config, pkgs, lib, ... }:

{
  services.udisks2.enable = true;
  # services.gvfs.enable = true;
  programs.adb.enable = true; # for android devices
  # services.usbmuxd.enable = true; # for ios devices
  environment.systemPackages = with pkgs; [
    android-tools libmtp # for android
    # libimobiledevice # for ios
  ];
  # services.udev.enable = true;
}
