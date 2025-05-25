{ config, pkgs, ... }:

{
  hardware.opengl.enable = true;
  # hardware.opengl.driSupport = true;
  # hardware.graphics = {
  #   extraPackages = with pkgs; [
  #     intel-media-driver
  #     vaapiIntel
  #     vaapiVdpau
  #     libvdpau-va-gl
  #   ];
  # };
}
