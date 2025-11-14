{ pkgs, ... }:

pkgs.writeScriptBin "gitc" ''
#!/usr/bin/env nu

const ERROR = $"(ansi red)[ERROR](ansi reset)"
const INFO = $"(ansi blue)[INFO](ansi reset)"

const PROFILE = {
  "github": { "email": "152054612+sumitftr@users.noreply.github.com", "username": "sumitftr" },
  "gitlab": { "email": "22763302-sumitftr@users.noreply.gitlab.com", "username": "sumitftr" },
  "test": { "email": "142516692+sumit-modak@users.noreply.github.com", "username": "sumit-modak" },
}

# extract domain and username from git URL
def extract [url: string] {
    let result = if ($url | str starts-with "git@") {
        $url | parse "git@{domain}:{username}/{repo}" | get 0
    } else if ($url | str starts-with "http") {
        $url | parse "{protocol}://{domain}/{username}/{repo}" | get 0
    }
    { domain: $result.domain, username: $result.username }
}

def main [] {
    # Check if we're in a git repository
    if (git rev-parse --git-dir | complete | get exit_code) != 0 {
        print $"($ERROR)Error: Not a git repository"
        exit 1
    }

    let values = extract (git remote get-url origin | str trim)

    if $values.domain == "github" and $values.username == $PROFILE.github.username {
        git config --local user.email $PROFILE.github.email
        print $"($INFO) Your email has been set to `(ansi red)($PROFILE.github.email)(ansi reset)`\n"
    } else if $values.domain == "gitlab" and $values.username == $PROFILE.gitlab.username {
        git config --local user.email $PROFILE.gitlab.email
        print $"($INFO) Your email has been set to `(ansi red)($PROFILE.gitlab.email)(ansi reset)`\n"
    } else if $values.domain == "test" and $values.username == $PROFILE.test.username {
        git config --local user.email $PROFILE.test.email
        print $"($INFO) Your email has been set to `(ansi red)($PROFILE.test.email)(ansi reset)`\n"
    } else {
        print $"($ERROR) Failed to set email\n"
    }
}
''
