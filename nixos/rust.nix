{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      rustup gcc pkg-config openssl glib
    ];
    variables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      RUST_BACKTRACE = 1;
    };
    sessionVariables = {
      PATH = [ "$PATH" "$HOME/.cargo/bin" ];
    };
  };
}
