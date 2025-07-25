{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      helix zellij git
      eza ripgrep unzip
      yazi btop bash # gh
      nixd vscode-langservers-extracted

      # extra utilities
      asciinema asciinema-agg presenterm
    ];
    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
      SUDO_EDITOR = "hx";
      _ZO_DOCTOR = 0;
    };
    sessionVariables = {
      PATH = [ "$PATH" "$HOME/.local/scripts" ];
    };
  };

  programs.nano.enable = false;

  # starship
  programs.starship = {
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

  # # bash
  # environment = {
  #   variables = {
  #     HISTSIZE = 10000;      # Number of commands to keep in memory
  #     HISTFILESIZE = 100000; # Number of lines to keep in the history file
  #   };
  # };
  # programs = {
  #   bash = {
  #     shellAliases = {
  #       c = "clear";
  #       ls = "eza -al --group-directories-first --icons";
  #       la = "eza -a --group-directories-first --icons";
  #       lt = "eza -alT --group-directories-first --icons --git-ignore";
  #       tree = "eza -aT --group-directories-first --icons --git-ignore";
  #       tmux = "zellij";
  #       btop = "btop --force-utf";
  #       todo = "hx ~/gen/todo/*";
  #       trash = "rm -rfv ~/.local/share/Trash/files/* ~/.local/share/Trash/info/*";
  #       template = "cat ~/dev/main/cses-problem-set/template.rs | wl-copy";
  #       lf = "yazi";
  #     };
  #   };
  # };
  # programs.zoxide = {
  #   enable = true;
  #   enableBashIntegration = true;
  #   flags = [ "--cmd cd" ];
  # };

  # # fzf
  # environment = {
  # systemPackages = with pkgs; [ fd fzf bat jq ];
  #   variables = {
  #     FZF_DEFAULT_COMMAND = "fd -ai --type f --hidden --ignore --exclude .git";
  #     FZF_DEFAULT_OPTS = "--reverse --bind 'ctrl-n:toggle+down,tab:down,shift-tab:up'";
  #   };
  # };
  # programs.fzf.fuzzyCompletion = true;
  # environment.etc."bash.bashrc".text = ''
  #   source "$(fzf --bash)"
  # '';
}
