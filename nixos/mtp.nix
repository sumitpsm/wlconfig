{ config, pkgs, ... }:

{
  services.gvfs.enable = true;
  # services.udisks2.enable = true;
  services.usbguard.enable = true;

  environment.systemPackages = with pkgs; [
    # mtpfs jmtpfs
    usbutils # For lsusb
    libmtp # For MTP support
  ];
}
