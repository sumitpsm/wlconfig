{ pkgs, terminal-tools, ... }:

{
  programs.nano.enable = false;
  documentation.man.enable = true;

  environment.systemPackages = with pkgs; [
    git
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

    opencode
  ] ++ terminal-tools;

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
}
