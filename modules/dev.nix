{ pkgs, ... }:

{
  programs.nano.enable = false;
  documentation.man.enable = true;

  environment.systemPackages = with pkgs; [
    helix git yazi btop # gh
    zoxide eza ripgrep unzip bash
    # asciinema asciinema-agg presenterm

    gcc pkg-config openssl
    rustc cargo clippy rustfmt rust-analyzer
    nixd vscode-langservers-extracted man-pages
    tailwindcss_4 tailwindcss-language-server
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
