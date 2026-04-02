{ config, pkgs, lib, devTools, ... }:

{
  programs.nano.enable = false;
  documentation.man.enable = true;

  environment.systemPackages = with pkgs; [
    # Development tools
    gcc
    pkg-config
    openssl
    bash
    rustc
    cargo
    clippy
    rustfmt
    rust-analyzer
    man-pages
    dprint
    nixd
    markdown-oxide
    vscode-langservers-extracted

    # Miscellaneous tools
    ffmpeg-full
    # handbrake
    imagemagick
    # exiftool
    zip
    unzip
    p7zip
    yt-dlp

    dive
    nerdctl
    podman-compose
    docker-compose

    pgadmin4
    opencode
    # gh tailwindcss_4 tailwindcss-language-server 
  ] ++ devTools;

  environment.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";

    # Rust specific environment variables
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    RUST_BACKTRACE = 1;
    # PATH = [];
  };

  users.users.${config.user.name}.extraGroups = ["libvirtd" "docker"];
  virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.containers.enable = true;
  
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
    extraPackages = [ 
      pkgs.crun
      pkgs.runc
      pkgs.kata-runtime
    ];
  };
  
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      runtimes = {
        crun = { path = "${pkgs.crun}/bin/crun"; };
        kata = { path = "${pkgs.kata-runtime}/bin/kata-runtime"; };
      };
    };
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    enableTCPIP = true;
    settings = {
      port = 5432;
    };
  };
  systemd.services.postgresql.wantedBy = lib.mkForce [];
  systemd.targets.postgresql.wantedBy = lib.mkForce [];
}
