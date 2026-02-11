{ pkgs, inputs, devTools, ... }:

{
  programs.nano.enable = false;
  documentation.man.enable = true;

  environment.systemPackages = devTools;

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

  environment.variables = {};
}
