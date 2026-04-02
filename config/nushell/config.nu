$env.config = {
  buffer_editor: "hx"
  edit_mode: "vi"
  table: { mode: "psql" }
  completions: { algorithm: "fuzzy" sort: "smart" }
  show_banner: false
  use_kitty_protocol: true
  keybindings: [ # history_menu completion_menu ide_completion_menu help_menu
    { name: move_left                  mode: vi_normal keycode: char_e  modifier: none          event: { send: Left } }
    { name: move_down                  mode: vi_normal keycode: char_i  modifier: none          event: { send: Down } }
    { name: move_up                    mode: vi_normal keycode: char_y  modifier: none          event: { send: Up } }
    { name: move_right                 mode: vi_normal keycode: char_o  modifier: none          event: { send: Right } }
    { name: move_line_start            mode: vi_normal keycode: char_e  modifier: shift         event: { edit: MoveToStart } }
    { name: move_line_end              mode: vi_normal keycode: char_o  modifier: shift         event: { edit: MoveToEnd } }
    { name: history_hint_complete      mode: vi_insert keycode: tab     modifier: control       event: { send: HistoryHintComplete } }
    { name: history_hint_word_complete mode: vi_insert keycode: backtab modifier: control_shift event: { send: HistoryHintWordComplete } }
    { name: history_menu               mode: vi_insert keycode: backtab modifier: shift         event: { until: [ { send: menuprevious } { send: menu name: history_menu } ] } }
    { name: disable_ctrl_r             mode: vi_insert keycode: char_r  modifier: control       event: { send: none } }
    { name: disable_ctrl_a             mode: vi_insert keycode: char_a  modifier: control       event: { send: none } }
    { name: disable_ctrl_d             mode: vi_insert keycode: char_d  modifier: control       event: { send: none } }
    { name: disable_ctrl_j             mode: vi_insert keycode: char_j  modifier: control       event: { send: none } }
    { name: disable_ctrl_o             mode: vi_insert keycode: char_o  modifier: control       event: { send: none } }
    { name: disable_ctrl_q             mode: vi_insert keycode: char_q  modifier: control       event: { send: none } }
    { name: disable_ctrl_w             mode: vi_insert keycode: char_w  modifier: control       event: { send: none } }
    { name: disable_ctrl_shift_a       mode: vi_insert keycode: char_a  modifier: control_shift event: { send: none } }
    { name: disable_alt_enter          mode: vi_insert keycode: enter   modifier: alt           event: { send: none } }
  ]
}

$env.PATH = (
    $env.PATH 
    | append $"($nu.home-dir)/.cargo/bin"
    | append $"($nu.default-config-dir)/scripts"
    | uniq
)

alias c = clear
alias btop = btop --force-utf
def kmux [] { ^$"($nu.home-dir)/.config/kitty/kmux" }
def --env s [...rest] { ^$"($nu.home-dir)/.config/zellij/scripts/zsession" ...$rest }
# def ip [...args] { ^ip --json ...$args | from json }
# def bridge [...args] { ^bridge --json ...$args | from json }
# $env.DOCKER_HOST = $"unix://($env.XDG_RUNTIME_DIR)/docker.sock"

# auto-start hyprland
if (tty) == "/dev/tty1" {
  zoxide init nushell --cmd cd | save -f ($nu.user-autoload-dirs | path join zoxide.nu)
  exec start-hyprland
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
