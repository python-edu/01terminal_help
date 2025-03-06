#!/bin/bash

# define editor
# EDITOR="micro"
# EDITOR="nano"
EDITOR="nvim"

# Allows the user to set their favorite editor (default is nano)
export EDITOR="${EDITOR:-nano}"

# nvv function - search files and open in user editor
nvv() {
    local file
    file=$(find "$HOME" -type f \( -name ".*" -o -name "*" \) 2>/dev/null \
        | fzf --exact \
              --prompt="Enter file pattern: " \
              --info=inline \
              --preview='if file --mime {} | grep -q text; then cat {}; else echo " ---"; fi'
         )
    
    if [[ -n "$file" ]]; then
        "$EDITOR" "$file"
    fi
}

# cdd function - search directories and go to the selected one
cdd() {
    local dir
    dir=$(find "$HOME" -type d \( -name ".*" -o -name "*" \) 2>/dev/null \
        | fzf --exact \
              --prompt="Enter directory template: " \
              --preview='tree -L 1 -F --dirsfirst {}'
          )
    
    if [[ -n "$dir" ]]; then
        cd "$dir"
        ls -gh
    fi
}


# Export functions to work in terminal
export -f nvv
export -f cdd

