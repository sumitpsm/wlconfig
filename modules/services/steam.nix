{ config, pkgs, lib, ... }:

{
  options.steam = {
    enable = lib.mkEnableOption "Enable Steam";
    default = false;
  };

  config = lib.mkIf config.steam.enable {
    nixpkgs.config.allowUnfree = true;
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = false;
        gamescopeSession.enable = true;
        extraCompatPackages = [pkgs.proton-ge-bin];
      };
      gamescope = {
        enable = true;
        capSysNice = true;
        args = [
          "--rt"
          "--expose-wayland"
        ];
      };
    };
  };
}
