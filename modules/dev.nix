{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      helix zellij git
      zoxide starship eza ripgrep unzip
      yazi btop bash # gh
      nixd vscode-langservers-extracted

      # extra utilities
      asciinema asciinema-agg presenterm
    ];
    variables = {};
    sessionVariables = {};
  };

  programs.nano.enable = false;
}
