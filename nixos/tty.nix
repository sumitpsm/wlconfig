{ config, pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      helix yazi zellij fzf
      eza fd ripgrep jq unzip
      rustup gcc pkg-config openssl
      git curl nmap
      cht-sh
    ];
    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
      SUDO_EDITOR = "hx";
      RUST_BACKTRACE = 1;
    };
    sessionVariables = {
      PATH = [ "$PATH" "$HOME/.local/scripts" "$HOME/.cargo/bin" ];
    };
  };

  programs = {
    bash = {
      shellAliases = {
        c = "clear";
        ls = "eza -al --group-directories-first --icons";
        la = "eza -a --group-directories-first --icons";
        tree = "eza -aT --group-directories-first --icons";
        lf = "yazi";
        tmux = "zellij";
        todo = "hx /home/sumit/dev/todo";
      };
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      flags = [ "--cmd cd" ];
    };
    nano.enable = false;
  };

  # adds the sshd.service to path without enabling it
  services.openssh.enable = true;
  systemd.services.sshd.wantedBy = lib.mkForce [];

  # enables the polkit service
  security.polkit.enable = true;

  virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;

  networking = {
    networkmanager.enable = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
