# re-renders all environment variables set by nixos-configuration (disabled by default)

# let $env_vars = [
#   EDITOR
#   VISUAL
#   SUDO_EDITOR
#   PKG_CONFIG_PATH
#   RUST_SRC_PATH
#   RUST_BACKTRACE
# ];

# env | parse '{key}={value}' | where key in $env_vars | each { |row| $env.$row.key = $row.value } | ignore

alias btop = btop --force-utf
alias todo = hx ~/gen/todo/*
alias stoicism = ^$env.EDITOR ...(ls ~/notes/stoicism/**/[0-9]*).name

# def mux [] {
#     kitten @ action set_tab_title "git"
#     kitten @ action new_tab_with_cwd
#     kitten @ action set_tab_title "run"
#     kitten @ action new_tab_with_cwd
#     kitten @ action set_tab_title "code"
# }

def --env myfiles [] {
    # let partition = lsblk | lines | where { $in | str contains "931.5G" } | where { $in | str contains "part" } | split words | get 0.0
    let partition = lsblk --json | from json | get blockdevices | where size == "931.5G" | get children.0.name.0
    let result = udisksctl mount -b /dev/($partition) | complete
    let dirpath: path = match $result.exit_code {
        0 => {
            $result.stdout
            | str trim
            | parse "Mounted {device} at {dirpath}"
            | get 0.dirpath
        },
        _ => {
            $result.stderr
            | str trim
            | split row ' '
            | get 10
            | parse "`{dirpath}'."
            | get dirpath.0
        }
    }
    cd $dirpath
}

def kmap [] {
  sudo kmonad -linfo ~/dev/colemaxx.kbd | save -f ~/.kmonad.log
}
