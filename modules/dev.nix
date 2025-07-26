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
    sessionVariables = {
      PATH = [ "$PATH" "$HOME/.local/scripts" ];
      EDITOR = "hx";
      VISUAL = "hx";
      SUDO_EDITOR = "hx";
      _ZO_DOCTOR = 0;
    };
  };

  programs.nano.enable = false;
}
