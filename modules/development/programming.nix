{ pkgs, terminal-tools, ... }:

{
  documentation.man.enable = true;

  environment.systemPackages = with pkgs; [
    git
    gcc
    pkg-config
    openssl
    rust-bin.stable.latest.default
    rust-bin.stable.latest.rust-analyzer
    man-pages
    dprint
    nixd
    markdown-oxide

    bash
  ] ++ terminal-tools;

  environment.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";

    PKG_CONFIG_PATH = [ "${pkgs.openssl.dev}/lib/pkgconfig" ];
    RUST_BACKTRACE = 1;
    # PATH = [];
  };
}
