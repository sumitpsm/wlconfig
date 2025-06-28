{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      helix yazi zellij gitui btop
      eza fd ripgrep unzip
      git jq
      nixd vscode-langservers-extracted
    ];
    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
      SUDO_EDITOR = "hx";
    };
    sessionVariables = {
      PATH = [ "$PATH" "$HOME/.local/scripts" ];
    };
  };

  programs = {
    bash = {
      shellAliases = {
        c = "clear";
        ls = "eza -al --group-directories-first --icons";
        la = "eza -a --group-directories-first --icons";
        lt = "eza -alT --group-directories-first --icons --git-ignore";
        tree = "eza -aT --group-directories-first --icons --git-ignore";
        lf = "yazi";
        tmux = "zellij";
        btop = "btop --force-utf";
        todo = "hx /home/${config.user.name}/gen/todo/*";
      };
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      flags = [ "--cmd cd" ];
    };
    nano.enable = false;
  };
}
