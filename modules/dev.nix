{ pkgs, inputs, ... }:

{
  # nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
  programs.nano.enable = false;

  environment.systemPackages = with pkgs; [
    # development utilities
    helix git yazi btop # gh
    zoxide eza ripgrep unzip
    bash nixd vscode-langservers-extracted
    # asciinema asciinema-agg presenterm

    rustup gcc pkg-config openssl
    # # rust toolchains
    # (rust-bin.stable.latest.default.override {
    #   extensions = [
    #     "rust-src"
    #     "rust-analyzer"
    #   ];
    #   targets = [
    #     "x86_64-unknown-linux-gnu"
    #     "wasm32-unknown-unknown"
    #   ];
    # })
    # (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default))
  ];
  environment.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";
    PATH = [ "$HOME/.cargo/bin" ];

    # Rust specific environment variables
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    # RUST_SRC_PATH = "${pkgs.rust-bin.stable.latest.default}/lib/rustlib/src/rust/library";
    # RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    RUST_BACKTRACE = 1;
  };
  environment.variables = {};
}
