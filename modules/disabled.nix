{ lib, ... }:

{
  # Remove default packages (perl, rsync, strace, etc.)
  environment.defaultPackages = lib.mkForce [];

  # Disable unnecessary documentation
  documentation = {
    doc.enable = false;
    info.enable = false;
    nixos.enable = false;   # NixOS HTML manual (nixos-help)
  };

  programs.nano.enable = false;

  systemd.oomd.enable = false;
  systemd.services.systemd-machined.enable = false;

}
