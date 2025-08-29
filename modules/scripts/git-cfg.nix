{ pkgs, ... }:

pkgs.writeScriptBin "git-cfg" ''
#!/usr/bin/env nu

const ERROR = $"(ansi red)[ERROR](ansi reset)"
const WARN = $"(ansi yellow)[WARN](ansi reset)"
const INFO = $"(ansi blue)[INFO](ansi reset)"

def set_mail [email: string] {
  let current_email = (^git config get --local user.email | str trim)

  if $current_email == $email {
    print $"($INFO) Your email is properly set \(Email: `(ansi red)($email)(ansi reset)`)\n"
  } else {
    if not ($current_email | is-empty) {
      print $"($WARN) Your email is not properly set \(Email: `(ansi red)($current_email)(ansi reset)`)\n"
    }
    let input = (input $"($WARN) Would you like to set proper email [y/n]? " --numchar 1)
    if $input =~ "[yY]" {
      git config --local user.email $email
      print $"($INFO) Your email has been set to `(ansi red)($email)(ansi reset)`)\n"
    }
  }
}

def main [arg?: string] {
  const main_email = "152054612+sumitftr@users.noreply.github.com"
  const test_email = "142516692+sumit-modak@users.noreply.github.com"

  if ($arg | is-empty) {
    # Extract SSH profile from remote.origin.url
    let ssh_profile = (git config get --local remote.origin.url
      | str replace --regex '.*@(.*):.*' '$1' 
      | str trim)
  
    if $ssh_profile == "main" {
      set_mail $main_email
    } else if $ssh_profile == "test" {
      set_mail $test_email
    } else {
      print $"($ERROR) Remote `origin` didn't match with ssh profiles\n"
    }
    git config --local user.name "Sumit Modak"

  } else if $arg == "main" {
    git config --global user.email $main_email
    print $"($INFO) Global email changed to sumit-ftr\n"
  } else if $arg == "test" {
    git config --global user.email $test_email
    print $"($INFO) Global email changed to sumit-modak\n"
  } else {
    print $"($ERROR) SSH profile not found\n"
  }
}
''
