# Dev tools package bundle
# All development and terminal tools used across NixOS and non-NixOS systems

{ pkgs }:

let
  terminal-tools = with pkgs; [
    nushell helix zellij ripgrep yazi btop zoxide
  ];
in
{
  # Export the package list for use in NixOS modules
  inherit terminal-tools;

  # Build environment for non-NixOS systems
  terminal = pkgs.buildEnv {
    name = "terminal";
    paths = terminal-tools;
    meta = {
      description = "Development tools bundle for non-NixOS systems";
    };
  };
}
