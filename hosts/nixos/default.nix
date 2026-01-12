{ ... }:

{
  imports = [
    ./hardware.nix
    ./packages.nix
    ./../../modules/drivers/amd-drivers.nix
  ];
  system.stateVersion = "25.11";

  services.kmonad = {
    enable = true;
    keyboards = {
      myKMonadOutput = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = builtins.readFile ./colemaxx.kbd;
      };
    };
  };

  # [CUSTOM OPTIONS]
  laptop.enable = true;
}
