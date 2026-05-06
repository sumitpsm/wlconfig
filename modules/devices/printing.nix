{ config, pkgs, lib, ... }:

{
  options.printing = {
    enable = lib.mkEnableOption "Enable Printing";
    default = false;
  };

  config = lib.mkIf config.printing.enable {
    services = {
      printing = {
        enable = true;
        drivers = [
          # pkgs.hplipWithPlugin
        ];
      };
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      ipp-usb.enable = true;
    };
  };
}
