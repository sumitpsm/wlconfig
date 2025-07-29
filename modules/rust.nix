{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
  environment = {
    systemPackages = with pkgs; [
      rustup gcc pkg-config openssl
      # rust toolchains
      (rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src"
          "rust-analyzer"
        ];
        targets = [
          "x86_64-unknown-linux-gnu"
          "wasm32-unknown-unknown"
        ];
      })
      (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default))
    ];
    variables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      RUST_SRC_PATH = "${pkgs.rust-bin.stable.latest.default}/lib/rustlib/src/rust/library";
    };
  };
}
