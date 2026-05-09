def list-drives [] {
    lsblk --json --output NAME,SIZE,FSTYPE,LABEL,MOUNTPOINT,UUID,TYPE
    | from json 
    | get blockdevices 
    | where type == "disk"
    | each { |disk|
        if ($disk.children? | is-not-empty) {
            $disk.children | each { |part|
                {
                    name: $part.name,
                    size: $part.size,
                    fstype: ($part.fstype? | default ""),
                    label: ($part.label? | default ""),
                    uuid: ($part.uuid? | default ""),
                    mountpoint: ($part.mountpoint? | default ""),
                    is_mounted: ($part.mountpoint? | is-not-empty)
                }
            }
        } else {
            []
        }
    }
    | flatten
}

def --env mount-drive [] {
    let drives = list-drives

    if ($drives | is-empty) {
        print "No drives found."
        return
    }

    let drive_info = $drives | input list --fuzzy

    if ($drive_info | is-empty) {
        print "No drive selected."
        return
    }

    let dirpath = if (not $drive_info.is_mounted) {
        print $"Mounting /dev/($drive_info.name)..."
        let result = udisksctl mount -b $"/dev/($drive_info.name)" | complete

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
        $dirpath
    } else {
        print $"Drive already mounted at ($drive_info.mountpoint)"
        $drive_info.mountpoint
    }

    print $"Changing directory to ($dirpath)"
    cd $dirpath
}
