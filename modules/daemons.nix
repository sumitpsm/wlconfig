{ config, lib, ... }:

{
  users.users.${config.user.name}.extraGroups = [
    "networkmanager"
    "libvirtd"
  ];

  security.polkit.enable = true;
  services.udisks2.enable = true;

  # DHCP-CLIENT
  networking = {
    networkmanager.enable = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant
    firewall.enable = true;
    firewall.allowedTCPPorts = [];
    firewall.allowedUDPPorts = [];
  };

  # SSH
  services.openssh.enable = true;
  systemd.services.sshd.wantedBy = lib.mkForce [];

  # VIRTUALISATION
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # NETWORK-PROXY
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  systemd.oomd.enable = false;
  systemd.services.systemd-machined.enable = false;
}
