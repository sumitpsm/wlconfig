{ config, ... }:

{
  users.users.${config.user.name}.extraGroups = ["libvirtd"];
  virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;
}
