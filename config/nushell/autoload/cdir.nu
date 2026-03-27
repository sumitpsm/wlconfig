def --env cdir [] {
    let all_dirs = (
        [$"($env.HOME)/.config" $"($env.HOME)/.local"]
        | append (do -i { ls ~/dev/*/* ~/* | where type == dir and name !~ $'($env.HOME)/\.' | get name })
        | append (do -i { ls $"/run/media/($env.USER)/*" | get name })
    )

    let selected = ($all_dirs | each { str replace $env.HOME "~" } | input list --fuzzy)
    cd $selected
}

def --env f [] {
    let cwd_file = mktemp -t yazi-cwd.XXXXXX
    yazi --cwd-file $cwd_file
    cd (open $cwd_file | str trim)
}
