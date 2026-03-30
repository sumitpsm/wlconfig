#!/usr/bin/env nu

const ERROR = $"(ansi red)[ERROR](ansi reset)"
const OK = $"(ansi green)[OK](ansi reset)"
const WARN = $"(ansi yellow)[WARN](ansi reset)"
const INFO = $"(ansi blue)[INFO](ansi reset)"

# user configs to link
const user_configs = [
    ["source",                      "destination"];
    ["config/nushell",              ".config/nushell"],
    ["config/helix",                ".config/helix"],
    ["config/zellij",               ".config/zellij"],
    ["config/ssh_config",           ".ssh/config"],
    ["config/.gitconfig",           ".gitconfig"],
    ["config/yazi",                 ".config/yazi"],
    ["config/hypr",                 ".config/hypr"],
    ["config/kitty",                ".config/kitty"],
    ["config/alacritty",            ".config/alacritty"],
    ["config/dprint",               ".config/dprint"],
    ["config/emojis.csv",           ".local/share/emojis.csv"],
    ["config/GIMP/3.0/gimprc",      ".config/GIMP/3.0/gimprc"],
    ["config/GIMP/3.0/sessionrc",   ".config/GIMP/3.0/sessionrc"],
    ["config/GIMP/3.0/shortcutsrc", ".config/GIMP/3.0/shortcutsrc"],
    ["config/GIMP/3.0/toolrc",      ".config/GIMP/3.0/toolrc"],
    ["config/gtk-3.0",              ".config/gtk-3.0"],
    ["config/btop",                 ".config/btop"],
]

# root configs to link
const root_configs = [
    ["source",                      "destination"];
    [".config/nushell",             ".config/nushell"],
    [".config/helix",               ".config/helix"],
    [".config/zellij",              ".config/zellij"],
    [".config/yazi",                ".config/yazi"],
    [".config/dprint",              ".config/dprint"],
    [".config/btop",                ".config/btop"],
]

def main [] {
    # initializing config directory
    let config_dir = $env.CURRENT_FILE | path dirname

    # check for flake.nix
    if not ($config_dir | path join "flake.nix" | path exists) {
        print $"($ERROR) `flake.nix` not found in ($env.dir)"
        exit 1
    }

    # get the real user's home directory (works with or without sudo)
    let real_home = if "SUDO_USER" in $env {
        ^getent passwd $env.SUDO_USER | split column ":" | get column5.0
    } else {
        $env.HOME
    }

    # Link user configs
    for config in $user_configs {
        let source = $"($config_dir)/($config.source)"
        let destination = $"($real_home)/($config.destination)"
    
        if ($source | path exists) {
            update_symlink $source $destination
        } else {
            print $"($ERROR) Source not found: ($source)"
        }
    }

    # link root configs if the script is running in sudo mode
    if (id -u | into int) == 0 {
        for config in $root_configs {
            let source = $"($real_home)/($config.source)"
            let destination = $"/root/($config.destination)"
    
            if ($source | path exists) {
                update_symlink $source $destination
            } else {
                print $"($ERROR) Source not found: ($source)"
            }
        }
    }
}

def update_symlink [source: path, destination: path] {
    let dest_parent = ($destination | path dirname)
    
    # Create parent directory if it doesn't exist
    if not ($dest_parent | path exists) {
        mkdir $dest_parent
    }
    
    # Check if destination exists
    if ($destination | path exists) {
        # Check if it's a symlink
        if ($destination | path type) == 'symlink' {
            let current_target = (ls -lD $destination | get target.0)
            if $source == $current_target {
                print $"($INFO) Already linked: ($destination)"
                return
            } else {
                # Remove incorrect symlink without backup
                print $"($WARN) Removing incorrect symlink: ($destination) -> ($current_target)"
                rm $destination
            }
        } else {
            # Only backup if it's NOT a symlink (i.e., it's a regular file or directory)
            let backup = $"($destination).bak"
            print $"($WARN) Creating backup: ($backup)"
            mv -f $destination $backup
        }
    }
    
    # Create symlink
    print $"($OK) Linking: ($destination) -> ($source)"
    ln -s $source $destination
}
