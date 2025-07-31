{ pkgs, ... }:

pkgs.writeScriptBin "tscp" ''
#!/usr/bin/env nu

# tscp stands for terminal sequence color palette
# This script prints the current terminal sequence
# color palette in terminal

def main [] {
  print ""
  for i in 0..16 {
    print -n $"(ansi -e $'38;5;($i)m')████(ansi reset) "
    if (($i + 1) mod 8) == 0 {
      print ""
    }
  }
}
''
