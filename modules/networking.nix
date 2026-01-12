{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    traceroute
    wireshark tcpdump # termshark // for TUI
    # zap # web pentesting utility
  ];

  # wireshark configuration
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
    usbmon.enable = true;
  };
  users.users.${config.user.name}.extraGroups = [
    "wireshark"
    "networkmanager"
  ];

  networking = {
    networkmanager.enable = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };

  # adds the sshd.service to path without enabling it
  services.openssh.enable = true;
  systemd.services.sshd.wantedBy = lib.mkForce [];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
