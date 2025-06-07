{ config, pkgs, lib, ... }:

{
  options.autoCleanup = {
    enable = lib.mkEnableOption "Enable Automatic Cleanup";
    default = false;
  };

  config = lib.mkIf config.autoCleanup.enable {
    nix = {
      gc.automatic = true;
      gc.dates = "monthly";
      gc.options = "--delete-older-than 14d";
      settings.auto-optimise-store = true;
    };
  };
}
