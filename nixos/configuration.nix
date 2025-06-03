{ config, pkgs, ... }:

{
  imports = [ 
    ./boot.nix
    ./tty.nix
    ./sound.nix
    ./foreigndevices.nix
    ./wayland.nix
    ./rust.nix
    ./programs.nix
  ];

  # Time Zone
  time.timeZone = "Asia/Kolkata";

  i18n = {
    defaultLocale = "en_IN"; # internationalisation properties
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  users.users.sumit = {
    isNormalUser = true;
    description = "SumitModak";
    extraGroups = [
      "networkmanager" # for networking
      "wheel" # for sudo privileges
      "libvirtd" # for virtualization
      "adbusers" # for debugging android devices
    ];
    packages = with pkgs; [];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Keyboard layout configuration
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
