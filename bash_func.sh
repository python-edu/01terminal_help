#!/bin/bash

# edit the line below - enter your editor
EDITOR="nvim"  #  "micro", "vim", "nano", ...

alias mc=$EDITOR

# Allows the user to set their favorite editor (default is nano)
export EDITOR="${EDITOR:-micro}"

# nvv function - search files and open in user editor
mcc() {
    local file
    file=$(find "$HOME" -type f \( -name ".*" -o -name "*" \) 2>/dev/null \
        | fzf --exact \
              --prompt="Enter file pattern: " \
              --info=inline \
              --preview='if file --mime {} | grep -q text; then batcat --color=always {} --style=numbers,changes; else echo " ---"; fi'
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
export -f mcc
export -f cdd

