#!/usr/bin/env nu

const LOCK_DIR = "/tmp/nu-recorder"
const LOCK_FILE = "/tmp/nu-recorder/LOCK"

def stop_recording [] {
    if not ($LOCK_FILE | path exists) {
        ^hyprctl notify 1 2000 0 "No recording in progress"
        return
    }

    let pid = (open $LOCK_FILE | str trim | into int)
    ^kill -SIGTERM $pid
    rm $LOCK_FILE
}

def start_recording [recorder: string, args: list<string>] {
    mkdir $LOCK_DIR

    # Trap SIGTERM/SIGINT: kill recorder and clean up
    # (nushell doesn't have trap, so we use a bash wrapper for the wait loop)
    let args_str = ($args | each { |a| $"'($a)'" } | str join " ")
    ^bash -c $"
        echo \$\$ > ($LOCK_FILE)
        ($recorder) ($args_str) &
        RECORDER_PID=\$!
        trap 'kill -TERM \$RECORDER_PID; rm -f ($LOCK_FILE)' TERM INT
        wait \$RECORDER_PID
    "
}

def get_recorder [] {
    if (which wf-recorder | is-not-empty) {
        "wf-recorder"
    } else if (which wl-screenrec | is-not-empty) {
        "wl-screenrec"
    } else {
        error make {msg: "Neither wl-screenrec nor wf-recorder found"}
    }
}

def build_args [recorder: string, mode: string] {
    let file = $"($env.HOME)/media/.recordings/(date now | format date "%Y-%m-%d_%H-%M-%S").mp4"
    let audio_dev = (^pw-dump | from json | where {|it| ($it.info?.props? | default {} | get "media.class"? | default "") == "Audio/Sink" and ($it.info?.props? | default {} | get "node.name"? | default "") != ""} | get 0?.info?.props?."node.name"? | default "default") + ".monitor"

    match $recorder {
        "wf-recorder" => {
            match $mode {
                "full"   => [-f $file $"--audio=($audio_dev)"]
                "region" => [-f $file -g (slurp) $"--audio=($audio_dev)"]
                "video"  => [-f $file ]
                _ => []
            }
        }
        "wl-screenrec" => {
            match $mode {
                "full"   => [-f $file --low-power=off --audio-device $audio_dev]
                "region" => [-f $file --low-power=off --geometry (slurp) --audio --audio-device $audio_dev]
                "audio"  => [-f $file --low-power=off --audio --audio-device $audio_dev]
                _ => []
            }
        }
        _ => []
    }
}

def main [mode: string] {
    # Stop if already recording
    if ($LOCK_FILE | path exists) {
        stop_recording
        ^hyprctl notify 5 2000 0 "Recording stopped"
        return
    }

    let recorder = (get_recorder)

    let args = (build_args $recorder $mode)

    ^hyprctl notify 5 2000 0 $"Recording started \(($recorder)\)"
    start_recording $recorder $args
}
