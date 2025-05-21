{ config, pkgs, ... }:

{
  imports = [ 
    ./tty.nix
    ./wayland.nix
    ./sound.nix
    ./programs.nix
  ];

  time.timeZone = "Asia/Kolkata"; # time zone

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
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
  };

  nix = {
    # automatic cleanup
    gc.automatic = true;
    gc.dates = "monthly";
    gc.options = "--delete-older-than 14d";
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11";
}
