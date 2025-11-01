{ pkgs, ... }:

pkgs.writeScriptBin "rs" ''
#!/usr/bin/env nu

# This script runs standalone rust programs

def main [file: string] {
  mkdir $"($env.HOME)/.cache/rs/"
  let basename_no_ext = ($file | path basename | str replace ".rs" "")
  # Compile and run the rust program, then remove the executable
  try {
    run-external "rustc" $file "-o" $"($env.HOME)/.cache/rs/($basename_no_ext)"
    rm --force $"($env.HOME)/.cache/rs/($basename_no_ext)"
  }
}
''
