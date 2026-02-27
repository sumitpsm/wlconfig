# Dev tools package bundle
# All development and terminal tools used across NixOS and non-NixOS systems

{ inputs, pkgs }:

let
  devTools = with pkgs; [
    # Terminal tools
    nushell
    helix
    # zellij
    yazi
    git
    ripgrep
    zoxide
    btop
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
