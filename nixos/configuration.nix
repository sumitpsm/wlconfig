{ config, pkgs, ... }:

{
  imports = [ 
    ./wayland.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true; # networking

  time.timeZone = "Asia/Kolkata"; # time zone

  i18n.defaultLocale = "en_IN"; # internationalisation properties

  i18n.extraLocaleSettings = {
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

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
    gc.options = "--delete-older-than 30d";
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  environment = {
    systemPackages = with pkgs; [
      git helix yazi zellij eza
      rustup pkg-config openssl
      ripgrep jq unzip
      curl nmap
    ];
    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
      RUST_BACKTRACE = 1;
    };
  };

  programs = {
    bash = {
      completion.enable = true;
      shellAliases = {
        c = "clear";
        ls = "eza -al --group-directories-first --icons";
        la = "eza -a --group-directories-first --icons";
        tree = "eza -aT --group-directories-first --icons";
        lf = "yazi";
        tmux = "zellij";
        gp = "nix-store -q --requisites /run/current-system ~/.nix-profile | grep";
        todo = "hx /home/sumit/dev/todo";
      };
    };
    nano.enable = false;
  };

  virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
