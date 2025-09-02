{ pkgs, ... }:

{
  programs.nano.enable = false;

  environment.systemPackages = with pkgs; [
    helix git yazi btop # gh
    zoxide eza ripgrep unzip
    bash nixd vscode-langservers-extracted
    # asciinema asciinema-agg presenterm

    gcc pkg-config openssl
    rustc cargo clippy rustfmt rust-analyzer
  ];

  environment.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";

    # Rust specific environment variables
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    RUST_BACKTRACE = 1;
    PATH = [ "$HOME/.cargo/bin" ];
  };

  environment.variables = {};
}
