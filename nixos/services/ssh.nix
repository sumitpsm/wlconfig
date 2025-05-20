{ config, pkgs, ... }:

{
  # networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh.enable = true;
}
