{ pkgs, ... }:

pkgs.writeScriptBin "rs" ''
#!/usr/bin/env nu

# This script runs standalone rust programs

def main [file: string] {
  mkdir $"($env.HOME)/.cache/rs/"
  let basename_no_ext = ($file | path basename | str replace ".rs" "")
  let executable = $"($env.HOME)/.cache/rs/($basename_no_ext)"
  
  try {
    run-external "rustc" $file "-o" $executable
    run-external $executable
    rm --force $executable
  }
}
''
