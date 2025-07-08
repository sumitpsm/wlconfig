{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      helix zellij btop git
      eza fd ripgrep jq unzip
      fzf bat yazi # gh
      nixd vscode-langservers-extracted

      # extras
      nushell
      presenterm
      asciinema
      asciinema-agg 
    ];
    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
      SUDO_EDITOR = "hx";
      FZF_DEFAULT_COMMAND = "fd -ai --type f --hidden --ignore --exclude .git";
      FZF_DEFAULT_OPTS = "--reverse --bind 'ctrl-n:toggle+down,tab:down,shift-tab:up'";
      HISTSIZE = 10000;      # Number of commands to keep in memory
      HISTFILESIZE = 100000; # Number of lines to keep in the history file
    };
    sessionVariables = {
      PATH = [ "$PATH" "$HOME/.local/scripts" ];
    };
  };

  environment.etc."bash.bashrc".text = ''
    source "$(fzf --bash)"
  '';

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
        lf = "yazi";
      };
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      flags = [ "--cmd cd" ];
    };
    fzf.fuzzyCompletion = true;
    nano.enable = false;
  };
}
