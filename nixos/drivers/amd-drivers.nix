{ config, pkgs, ... }:

{
  hardware.opengl.enable = true;
  # hardware.opengl.driSupport = true;
  # systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  # services.xserver.videoDrivers = [ "amdgpu" ];
}
