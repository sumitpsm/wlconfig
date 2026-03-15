def --env cdir [] {
    let all_dirs = (
        [$"($env.HOME)/.config" $"($env.HOME)/.local"]
        | append (do -i { ls ~/dev/alt/* ~/dev/clone/* ~/dev/github/* ~/dev/gitlab/* ~/dev/wl/* | get name })
        | append (do -i { ls ~/*/* ~/* | where type == dir and name !~ $'($env.HOME)/\.' | get name })
        | append (do -i { ls $"/run/media/($env.USER)/*" | get name })
    )

    let selected = ($all_dirs | each { str replace $env.HOME "~" } | input list --fuzzy)
    cd $selected
}
