$env.config = {
  buffer_editor: "hx"
  edit_mode: "vi"
  show_banner: false
  completions: {
    algorithm: "fuzzy"
    sort: "smart"
  }
  table: { mode: "psql" }
  use_kitty_protocol: true
  keybindings: [
    { name: move_left                  modifier: none keycode: char_e mode: vi_normal event: { send: Left } }
    { name: move_down                  modifier: none keycode: char_i mode: vi_normal event: { send: Down } }
    { name: move_up                    modifier: none keycode: char_y mode: vi_normal event: { send: Up } }
    { name: move_right                 modifier: none keycode: char_o mode: vi_normal event: { send: Right } }
    { name: move_line_start            modifier: shift keycode: char_e mode: vi_normal event: { edit: MoveToStart } }
    { name: move_line_end              modifier: shift keycode: char_o mode: vi_normal event: { edit: MoveToEnd } }
    { name: history_hint_complete      modifier: control keycode: tab mode: vi_insert event: { send: HistoryHintComplete } }
    { name: history_hint_word_complete modifier: control_shift keycode: backtab mode: vi_insert event: { send: HistoryHintWordComplete } }
  ]
}

alias c = clear
alias l = eza -al --group-directories-first --icons
alias la = eza -a --group-directories-first --icons
alias trash = rm -rfv ~/.local/share/Trash/files/* ~/.local/share/Trash/info/*
alias template = ^wl-copy (open ~/dev/main/cses-problem-set/template.rs)
alias lf = yazi
alias btop = btop --force-utf

$env.PATH = $env.PATH | append ($nu.default-config-dir | path join scripts)
zoxide init nushell --cmd cd | save -f ($nu.user-autoload-dirs | path join zoxide.nu)
# auto-start hyprland
if (tty) == "/dev/tty1" {
  exec uwsm start hyprland.desktop
}

# PROMPT CONFIGURATION
$env.PROMPT_COMMAND = { ||
  use std null_device
  let user_color = if $env.USER == "root" { (ansi red_bold) } else { (ansi green) }
  let git_branch = $"(try { git rev-parse --abbrev-ref HEAD e> $null_device } catch { "" })"
  let git_info = if $git_branch != "" {
    let git_status_output = (do -i { git status --porcelain })
    let git_status = if $git_status_output != "" {
        let lines = ($git_status_output | lines)
        let symbols = [
          (if ($lines | any { |line| $line =~ '^(UU|AA|DD)' }) { "⚠" } else { "" }) # Merge conflicts
          (if ($lines | any { |line| $line =~ '^[MADRC]'    }) { "+" } else { "" }) # Changes in index (staged)
          (if ($lines | any { |line| $line =~ '^R'          }) { "=" } else { "" }) # Renamed in index
          (if ($lines | any { |line| $line =~ '^.M'         }) { "!" } else { "" }) # Modified in working tree
          (if ($lines | any { |line| $line =~ '^.?D'        }) { "×" } else { "" }) # Deleted (index or working tree)
          (if ($lines | any { |line| $line =~ '^\?\?'       }) { "?" } else { "" }) # Untracked files
        ] | str join ""
        if $symbols != "" { $" (ansi red)($symbols)(ansi purple)" } else { "" }
      } else {
        ""  # Clean working tree
      }
      $"(ansi purple)\(($git_branch)($git_status))(ansi reset) "
    } else {
      "" # Not in a git repository
    }
  $"($user_color)($env.PWD | str replace $env.HOME "~")(ansi reset) ($git_info)"
}
