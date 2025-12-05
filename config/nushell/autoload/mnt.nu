def --env mnt [
    drive?: string@"list-unmounted-drives"  # Autocomplete unmounted drives
] {
    # If no drive specified, show error
    if ($drive | is-empty) {
        print "Please specify a drive. Press Ctrl+Space to see available drives."
        return
    }
    
    # Mount the selected partition
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
            # Already mounted, extract path from error message
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

# Custom completion function for unmounted drives
def "list-unmounted-drives" [] {
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
    | each { |part|
        let label_str = if ($part.label | is-empty) { "" } else { $" \(($part.label))" }
        {
            value: $part.name,
            description: $"($part.size)($label_str)"
        }
    }
}
