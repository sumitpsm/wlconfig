# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# See `help config nu` for more options

$env.config.show_banner = false
$env.config.table.mode = "rounded"
$env.config.buffer_editor = "hx"
$env.config.edit_mode = "vi"

$env.PATH = $env.PATH | append $"($env.HOME)/.local/scripts"
$env.EDITOR = "hx"
$env.VISUAL = "hx"
$env.SUDO_EDITOR = "hx"
$env._ZO_DOCTOR = 0

alias c = clear
alias l = eza -al --group-directories-first --icons
alias la = eza -a --group-directories-first --icons
alias todo = hx ~/gen/todo/*
alias trash = rm -rfv ~/.local/share/Trash/files/* ~/.local/share/Trash/info/*
alias template = ^wl-copy (open ~/dev/main/cses-problem-set/template.rs)
alias tmux = zellij
alias lf = yazi
alias btop = btop --force-utf

def kmap [] {
  sudo kmonad -linfo ~/dev/colemaxx.kbd | save -f ~/.kmonad.log
}

source ./keybindings/vi.nu

zoxide init nushell --cmd cd | save -f ($nu.data-dir | path join zoxide.nu)
source ($nu.data-dir | path join zoxide.nu)

# PROMPT CONFIGURATION
let user_color = if $env.USER == "root" { (ansi red_bold) } else { (ansi cyan) }
$env.PROMPT_COMMAND = {||
  let git_branch = $"(do -i { ^git rev-parse --abbrev-ref HEAD e>| ignore })"
  let git_branch_formatted = if $git_branch != "" { $"(ansi purple)\(($git_branch))(ansi reset)" }
  # let git_status = if ($git_branch | is-empty) { "" } else { $"($git_branch)" }
  $"($env.PWD | str replace $env.HOME "~") ($git_branch_formatted)($user_color)"
}
$env.PROMPT_INDICATOR_VI_INSERT = $"($user_color)> "
$env.PROMPT_INDICATOR_VI_NORMAL = $"($user_color): "

# starship init nu | save -f ($nu.data-dir | path join starship.nu)
# source ($nu.data-dir | path join starship.nu)
