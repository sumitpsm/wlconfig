{ pkgs, ... }:

{
  programs.nano.enable = false;
  documentation.man.enable = true;

  environment.systemPackages = with pkgs; [
    helix yazi opencode btop # gh
    git ripgrep zoxide eza
    ffmpeg-full zip unzip p7zip
    # asciinema asciinema-agg presenterm

    gcc pkg-config openssl bash
    rustc cargo clippy rustfmt rust-analyzer
    man-pages dprint markdown-oxide nixd vscode-langservers-extracted
    # tailwindcss_4 tailwindcss-language-server
  ];

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
