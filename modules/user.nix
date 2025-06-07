{ config, pkgs, lib, ... }:

let
  cfg = config.user;
in
{
  options.user = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "sumit";
    };
    description = lib.mkOption {
      type = lib.types.str;
      default = "SumitModak";
    };
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Asia/Kolkata";
    };
    locale = lib.mkOption {
      type = lib.types.str;
      default = "en_IN";
    };
    kbdLayout = lib.mkOption {
      type = lib.types.str;
      default = "us";
    };
  };

  config = {
    time.timeZone = "${cfg.timeZone}";
    i18n = {
      defaultLocale = "${cfg.locale}";
      extraLocaleSettings = {
        LC_ADDRESS = "${cfg.locale}";
        LC_IDENTIFICATION = "${cfg.locale}";
        LC_MEASUREMENT = "${cfg.locale}";
        LC_MONETARY = "${cfg.locale}";
        LC_NAME = "${cfg.locale}";
        LC_NUMERIC = "${cfg.locale}";
        LC_PAPER = "${cfg.locale}";
        LC_TELEPHONE = "${cfg.locale}";
        LC_TIME = "${cfg.locale}";
      };
    };
    users.users.${cfg.name} = {
      isNormalUser = true;
      description = "${cfg.description}";
      extraGroups = [
        "networkmanager" # for networking
        "wheel" # for sudo privileges
        "libvirtd" # for virtualization
        "adbusers" # for debugging android devices
      ];
      packages = with pkgs; [];
    };
    services.xserver.xkb = {
      layout = "${cfg.kbdLayout}";
      variant = "";
    };
  };
}
