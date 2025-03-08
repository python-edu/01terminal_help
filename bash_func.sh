#!/bin/bash
#
# The script contains functions that help search files and directories on the disk in the user's home directory. Each
# function exists in two versions:
#   - the first version uses the default programs in Linux: find and cat
#   - the second version uses programs that must be installed by the user: `fd` - a replacement for `find` and `bat`
#     (batcat) - a replacement for `cat`
#
# All functions use the `fzf` program, which must be installed by the user.
#
# Functions:
# - mcc: searches for files, displays the contents of text files and opens the selected file for reading
# - cdd: searches for directories, displays the contents of the selected directory and changes to the selected directory


# edit the line below - enter your editor
EDITOR="nvim"  #  "micro", "vim", "nano", ...

alias mc=$EDITOR
complete -o default -o filenames mc


# Allows the user to set their favorite editor (default is nano)
export EDITOR="${EDITOR:-micro}"

# nvv function - search files and open in user editor
mcc() {
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


mcc() {
    local file
    file=$(fd . "$HOME" -u -a -t f -I -E .git \
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
        clear
        cd "$dir"
        ls -gh
    fi
}


cdd() {
    local dir
    dir=$(fd . "$HOME" -u -a -t d -I -E .git \
        | fzf --exact \
              --prompt="Enter directory template: " \
              --preview='tree -L 1 -F --dirsfirst {}'
          )
    
    if [[ -n "$dir" ]]; then
        clear
        cd "$dir"
        ls -gh
    fi
}
