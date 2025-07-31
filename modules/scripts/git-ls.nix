{ pkgs, ... }:

pkgs.writeScriptBin "git-ls" ''
#!/usr/bin/env nu

# This command checks for git repositories present in the
# current working directory and lists their git status
# You can also pass the directory path as argument.

def main [repodir: path = ".."] {
  cd $repodir
  let cwd = (pwd)
  let dirs = (ls -l | where type == dir | get name)
  for dir in $dirs {
    try {
      cd $"($cwd)/($dir)"
      let count = (^git status -s | ^wc -l | into int)
      if $count != 0 {
        print $"(ansi yellow_bold)($cwd)/($dir)(ansi reset)"
        git status -s
        print ""
      }
    }
  }
}
''
