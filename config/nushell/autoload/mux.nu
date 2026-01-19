def --env mux [
    ...project_paths: string@"nu-complete-mux"  # Accept multiple paths with '...'
] {
    let is_todo_closed = (kitten @ ls | from json | get tabs.0.0.title) != "todo"
    # Open todo tab once
    if $is_todo_closed {
        kitten @ launch --type=tab --title=todo $env.EDITOR ...(ls ~/dev/todo/**/*).name
    }
    
    # Process each project path
    for project_path in $project_paths {
        kitten @ launch --type=tab --cwd=($project_path)
        kitten @ launch --type=tab --cwd=($project_path)
        kitten @ launch --type=tab --cwd=($project_path)
    }

    if $is_todo_closed {
        # Focus on the second tab (index 1)
        kitten @ focus-tab --match=index:1
    
        # Close the first tab (index 0)
        kitten @ close-tab --match=index:0
    }
}

def "nu-complete-mux" []: nothing -> list<string> {
    let dev_dirs = (
        ls ~/dev/*/* 
        | where type == dir 
        | where name !~ "dev/todo" and name !~ "dev/test"
        | get name
    )
    
    let notes_dirs = (
        ls ~/notes/* 
        | where type == dir 
        | get name
    )
    
    ($dev_dirs | append $notes_dirs | append "~/dev/test" | each { str replace $env.HOME "~"})
}
