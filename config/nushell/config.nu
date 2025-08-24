$env.config = {
  show_banner: false
  table: { mode: "rounded" }
  buffer_editor: "hx"
  edit_mode: "vi"
  use_kitty_protocol: true
  keybindings: [
    { name: move_left                modifier: none keycode: char_e mode: vi_normal event: { send: Left } }
    { name: move_down                modifier: none keycode: char_i mode: vi_normal event: { send: Down } }
    { name: move_up                  modifier: none keycode: char_y mode: vi_normal event: { send: Up } }
    { name: move_right               modifier: none keycode: char_o mode: vi_normal event: { send: Right } }
    { name: move_line_start          modifier: shift keycode: char_e mode: vi_normal event: { edit: MoveToStart } }
    { name: move_line_end            modifier: shift keycode: char_o mode: vi_normal event: { edit: MoveToEnd } }
    { name: history_hint_complete    modifier: control keycode: tab mode: vi_insert event: { send: HistoryHintComplete } }
  ]
}

alias c = clear
alias l = eza -al --group-directories-first --icons
alias la = eza -a --group-directories-first --icons
alias todo = hx ~/gen/todo/*
alias trash = rm -rfv ~/.local/share/Trash/files/* ~/.local/share/Trash/info/*
alias template = ^wl-copy (open ~/dev/main/cses-problem-set/template.rs)
alias lf = yazi

zoxide init nushell --cmd cd | save -f ($nu.user-autoload-dirs | path join zoxide.nu)

# PROMPT CONFIGURATION
$env.PROMPT_COMMAND = { ||
  use std null_device
  let user_color = if $env.USER == "root" { (ansi red_bold) } else { (ansi green) }
  let git_branch = $"(try { git rev-parse --abbrev-ref HEAD e> $null_device } catch { "" })"
  let git_branch_and_status = if $git_branch != "" {
    let git_status_output = (do -i { git status --porcelain })
    let git_status = if $git_status_output != "" {
      let s = ($git_status_output | lines | any { |line| $line =~ '^[MADRC]' }) # staged
      let r = ($git_status_output | lines | any { |line| $line =~ '^R' }) # renamed
      let m = ($git_status_output | lines | any { |line| $line =~ '^.M' }) # modified
      let d = ($git_status_output | lines | any { |line| $line =~ '^[D|.D]' }) # deleted
      let u = ($git_status_output | lines | any { |line| $line =~ '^\?\?' }) # untracked
      let c = ($git_status_output | lines | any { |line| $line =~ '^UU' }) # conflicts
      $" (ansi red)(if $c {'⚠'})(if $s {'+'})(if $r {'='})(if $m {'!'})(if $d {'x'})(if $u {'?'})(ansi purple)"
    } else { "" }
    $"(ansi purple)\(($git_branch)($git_status))(ansi reset) "
  }
  $"($user_color)($env.PWD | str replace $env.HOME "~")(ansi reset) ($git_branch_and_status)"
}
