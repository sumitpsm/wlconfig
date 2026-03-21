# Helper function to get file statuses
def "nu-complete git files" [
    --modified (-m)      # Modified files
    --staged (-s)        # Staged files
    --untracked (-u)     # Untracked files
]: nothing -> list<string> {
    let status_output = (^git status --porcelain | lines)
    
    $status_output | each { |line|
        let index_status = ($line | str substring 0..1 | str trim)
        let worktree_status = ($line | str substring 1..2 | str trim)
        let filepath = ($line | str substring 3.. | str trim)
        
        # Handle renames: "old -> new" - extract the new filename
        let filename = if ($filepath =~ ' -> ') {
            $filepath | split row ' -> ' | last | str trim
        } else {
            $filepath
        }
        
        let is_staged = ($index_status in ['M', 'A', 'D', 'R', 'C'])
        let is_modified = ($worktree_status in ['M', 'D'])
        let is_untracked = ($index_status == '?' and $worktree_status == '?')
        
        let include = (
            ($modified and $is_modified) or
            ($staged and $is_staged) or
            ($untracked and $is_untracked)
        )
        
        if $include { $filename } else { null }
    } | compact
}

# Autocomplete for git add (modified and untracked, excluding already staged)
def "nu-complete git add" []: nothing -> list<string> {
    nu-complete git files --modified --untracked
}

# Autocomplete for git restore (all modified files)
def "nu-complete git restore" []: nothing -> list<string> {
    nu-complete git files --modified
}

# Autocomplete for git restore --staged (all staged files)
def "nu-complete git restore staged" []: nothing -> list<string> {
    nu-complete git files --staged
}

# Autocomplete for git restore --worktree (all modified files)
def "nu-complete git restore worktree" []: nothing -> list<string> {
    nu-complete git files --modified
}

# Autocomplete for git restore --staged --worktree (staged OR modified)
def "nu-complete git restore both" []: nothing -> list<string> {
    nu-complete git files --modified --staged | uniq
}

export extern "git add" [
    ...files: string@"nu-complete git add"
]

export extern "git restore" [
    ...files: string@"nu-complete git restore"
]

export extern "git restore --staged" [
    ...files: string@"nu-complete git restore staged"
]

export extern "git restore --worktree" [
    ...files: string@"nu-complete git restore worktree"
]

export extern "git restore --staged --worktree" [
    ...files: string@"nu-complete git restore both"
]

export extern "git restore --worktree --staged" [
    ...files: string@"nu-complete git restore both"
]

###############################################################

# Autocomplete for git diff (modified files + branches)
def "nu-complete git diff" []: nothing -> list<string> {
    let modified_files = (nu-complete git files --modified --staged)
    
    let branches = (
        ^git branch --all
        | lines
        | each { |line| $line | str replace -r '[\*\+]\s*' '' | str trim }
    )
    
    let tags = (^git tag | lines)
    
    ($modified_files ++ $branches ++ $tags) | uniq
}

# Autocomplete for git diff --staged (only modified files + branches)
def "nu-complete git diff staged" []: nothing -> list<string> {
    let staged_files = (nu-complete git files --modified)
    
    let branches = (
        ^git branch --all
        | lines
        | each { |line| $line | str replace -r '[\*\+]\s*' '' | str trim }
    )
    
    ($staged_files ++ $branches) | uniq
}

export extern "git diff" [
    --staged
    --cached
    --stat
    --numstat
    --shortstat
    --name-only
    --name-status
    --no-index
    ...targets: string@"nu-complete git diff"
]

###############################################################

# Autocomplete for git switch
def "nu-complete git switch" []: nothing -> list<string> {
    let local_branches = (
        ^git branch
        | lines
        | each { |line| $line | str replace -r '[\*\+]\s*' '' | str trim }
    )

    let remote_branches = (
        ^git branch --remote
        | lines
        | each { |line| $line | str trim }
    )

    let tags = (
        ^git tag
        | lines
        | each { |line| $line | str trim }
    )

    # # Get recent commit hashes
    # let commits: list<string> = (
    #     ^git log --all --oneline
    #     | lines
    #     | each { |line| $line | split row ' ' | first }
    # )

    ($local_branches ++ $remote_branches ++ $tags) | uniq
}

# Export git commands with autocompletion
export extern "git switch" [
    target?: string@"nu-complete git switch"
    ...args: string
]
