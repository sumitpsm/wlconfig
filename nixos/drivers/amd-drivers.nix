{ config, pkgs, ... }:

{
  hardware.opengl.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
