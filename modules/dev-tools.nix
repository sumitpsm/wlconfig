# Dev tools package bundle
# All development and terminal tools used across NixOS and non-NixOS systems

{ pkgs, inputs }:

let
  devTools = with pkgs; [
    # Terminal tools
    helix
    yazi
    git
    ripgrep
    zoxide
    eza
    ffmpeg-full
    zip
    unzip
    p7zip

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
    yt-dlp
    opencode
    btop
    # tailwindcss_4 tailwindcss-language-server
    # gh asciinema asciinema-agg presenterm
  ];
in
{
  # Export the package list for use in NixOS modules
  inherit devTools;

  # Build environment for non-NixOS systems
  dev-tools = pkgs.buildEnv {
    name = "dev-tools";
    paths = devTools;
    meta = {
      description = "Development tools bundle for non-NixOS systems";
    };
  };
}
