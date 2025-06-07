{ config, pkgs, ... }:

{
  # automatic cleanup
  nix = {
    gc.automatic = true;
    gc.dates = "monthly";
    gc.options = "--delete-older-than 14d";
    settings.auto-optimise-store = true;
  };
}
