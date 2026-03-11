def "nu-complete-all-dirs" []: nothing -> list<string> {
    let all_dirs = (
        [$"($env.HOME)/.config" $"($env.HOME)/.local"]
        | append (do -i { ls ~/dev/clone/* ~/dev/github/* ~/dev/gitlab/* ~/dev/wl/* | get name })
        | append (do -i { ls ~/*/* ~/* | where type == dir and name !~ $'($env.HOME)/\.' | get name })
        | append (do -i { ls $"/run/media/($env.USER)/*" | get name })
    )
    
    ($all_dirs | each { str replace $env.HOME "~"})
}

