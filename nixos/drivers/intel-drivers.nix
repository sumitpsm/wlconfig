{ config, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      # your Open GL, Vulkan and VAAPI drivers
      vpl-gpu-rt          # for newer GPUs on NixOS >24.05 or unstable
      # onevpl-intel-gpu  # for newer GPUs on NixOS <= 24.05
      # intel-media-sdk   # for older GPUs
    ];
  };
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
