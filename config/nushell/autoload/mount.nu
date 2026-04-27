def list-drives [] {
    lsblk --json 
    | from json 
    | get blockdevices 
    | where type == "disk"
    | each { |disk|
        if ($disk.children? | is-not-empty) {
            $disk.children | each { |part|
                {
                    name: $part.name,
                    size: $part.size,
                    label: ($part.label? | default ""),
                    mountpoint: ($part.mountpoint? | default "")
                }
            }
        } else {
            []
        }
    }
    | flatten
    | where mountpoint == ""
}

def --env mount-drive [] {
    let drives = list-drives

    if ($drives | is-empty) {
        print "No unmounted drives found."
        return
    }

    let selection = $drives
    | each { |part|
        let label_str = if ($part.label | is-empty) { "" } else { $" · ($part.label)" }
        $"($part.name)  ($part.size)($label_str)"
    }
    | input list --fuzzy

    if ($selection | is-empty) {
        print "No drive selected."
        return
    }

    let drive = $selection | split row " " | first

    print $"Mounting /dev/($drive)..."
    let result = udisksctl mount -b $"/dev/($drive)" | complete

    let dirpath = match $result.exit_code {
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

    print $"Changing directory to ($dirpath)"
    cd $dirpath
}
