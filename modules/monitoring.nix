{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    uutils-hostname # hostname-hostname-debian
    exiftool
    nftables
    traceroute
  ];

  # wireshark configuration
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
    usbmon.enable = true;
  };
  users.users.${config.user.name}.extraGroups = [ "wireshark" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
