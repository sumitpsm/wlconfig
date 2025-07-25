# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# See `help config nu` for more options

$env.config.show_banner = false
$env.config.table.mode = "rounded"
$env.config.buffer_editor = "hx"
$env.config.edit_mode = "vi"

alias c = clear
alias l = eza -al --group-directories-first --icons
alias la = eza -a --group-directories-first --icons
alias lt = eza -alT --group-directories-first --icons --git-ignore
alias tree = eza -aT --group-directories-first --icons --git-ignore
alias tmux = zellij
alias todo = hx ~/gen/todo/*
alias trash = rm -rfv ~/.local/share/Trash/files/* ~/.local/share/Trash/info/*
alias template = open ~/dev/main/cses-problem-set/template.rs | wl-copy
alias lf = yazi
alias btop = btop --force-utf

source ($nu.data-dir | path join .zoxide.nu)
