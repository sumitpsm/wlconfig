{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      helix zellij gitui btop
      eza fd ripgrep jq unzip
      git fzf bat yazi # gh
      nixd vscode-langservers-extracted

      # extras
      presenterm
      asciinema
      asciinema-agg 
      nushell
    ];
    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
      SUDO_EDITOR = "hx";
      FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
      FZF_DEFAULT_OPTS = "--reverse --bind 'ctrl-n:toggle+down,tab:down,shift-tab:up'";
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
        tmux = "zellij";
        btop = "btop --force-utf";
        todo = "hx ~/gen/todo/*";
        trash = "rm -rfv ~/.local/share/Trash/files/* ~/.local/share/Trash/info/*";
        template = "cat ~/dev/main/cses-problem-set/template.rs | wl-copy";
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
