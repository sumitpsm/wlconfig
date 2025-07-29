def "nu-complete git checkout" []: nothing -> list<string> {
    # Get local branches
    let local_branches: list<string> = (
        ^git branch
        | lines
        | each { |line| $line | str replace -r '[\*\+]\s*' '' | str trim }
    )

    # Get remote branches (e.g., origin/main)
    let remote_branches: list<string> = (
        ^git branch --remote
        | lines
        | each { |line| $line | str trim }
    )

    # Get tags
    let tags: list<string> = (
        ^git tag
        | lines
        | each { |line| $line | str trim }
    )

    # Get recent commit hashes
    let commits: list<string> = (
        ^git log --all --oneline
        | lines
        | each { |line| $line | split row ' ' | first }
    )

    # Combine all completion options and ensure uniqueness
    ($local_branches ++ $remote_branches ++ $tags ++ $commits) | uniq
}

# Register the git checkout command with autocompletion
export extern "git checkout" [
    target?: string@"nu-complete git checkout"  # Branch, tag, or commit hash to check out
    ...args: string                            # Additional arguments (e.g., -b for new branch)
]
