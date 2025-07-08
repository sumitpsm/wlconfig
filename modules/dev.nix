{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      helix zellij btop git
      eza fd ripgrep jq unzip
      fzf fzf-git-sh bat yazi # gh
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
      _ZO_DOCTOR = 0;
    };
    sessionVariables = {
      PATH = [ "$PATH" "$HOME/.local/scripts" ];
    };
  };

  environment.etc."bash.bashrc".text = ''
    source "$(fzf --bash)"
    source ${pkgs.fzf-git-sh}/share/fzf-git-sh/fzf-git.sh
  '';

  programs = {
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        format = "$hostname$directory$git_branch$git_status$username";
        hostname = {
          ssh_only = true;
          format = "[$hostname]($style):";
        };
        directory = {
          truncation_length = 8;
          truncation_symbol = "";
          truncate_to_repo = false;
          style = "bold green";
        };
        git_branch = {
          symbol = " ";
          style = "bold purple";
          format = "on ([$symbol$branch]($style)) ";
        };
        username = {
          style_root = "bold red";
          style_user = "bold yellow";
          show_always = true;
          format = "[$user]($style) ";
          aliases = { root = "#"; "${config.user.name}" = "✖"; }; # ➜ ➜ ─➤
        };
      };
    };
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
