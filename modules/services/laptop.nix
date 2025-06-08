{ config, pkgs, lib, ... }:

{
  options.laptop = {
    enable = lib.mkEnableOption "Enables Laptop Specific Utilities";
    default = false;
  };

  config = lib.mkIf config.laptop.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];
    hardware.bluetooth.enable = true;
    services.blueman.enable = true; # For GUI management
  };
}
