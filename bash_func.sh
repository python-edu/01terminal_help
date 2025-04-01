#!/bin/bash
#
# The script contains functions that help search files and directories on the disk in the user's home directory.
#
# Dependencies:
#   - `fd` - a replacement for `find`
#   - `bat` - (batcat) - a replacement for cat
#   - `fzf` - fuzzy finder
#
#
# Functions:
# - mcc: searches for files, displays the contents of text files and opens the selected file for reading
# - cdd: searches for directories, displays the contents of the selected directory and changes to the selected directory



# edit the line below - enter your editor
EDITOR="nvim"  #  "micro", "vim", "nano", ...

alias mc=$EDITOR


# Allows the user to set their favorite editor (default is nano)
export EDITOR="${EDITOR:-micro}"

# ---

mcc() {
    local file file_list start_dir pattern
    local file_cmd grep_cmd preview_cmd

    # 🔍 Argumenty i ich interpretacja
    if [[ -d "$1" ]]; then
        start_dir="$(realpath -m "$1")"
        pattern="${2:-*}"
    else
        start_dir="$HOME"
        pattern="${1:-*}"
    fi

    # Automatyczne dopisanie '*.' jeśli tylko rozszerzenie (np. "txt" → "*.txt")
    if [[ "$pattern" != \** ]]; then
        pattern="*.$pattern"
    fi

    # Wyszukiwanie plików
    if command -v fd &>/dev/null; then
        file_list=$(fd --glob "$pattern" "$start_dir" -u -t f -E .git)
    else
        file_list=$(find "$start_dir" -type f -name "$pattern" -not -path "*/.git*")
    fi

    # Komenda podglądu
    if command -v batcat &>/dev/null; then
        file_cmd="batcat --color=always --style=numbers,changes"
    elif command -v bat &>/dev/null; then
        file_cmd="bat --color=always --style=numbers,changes"
    else
        file_cmd="cat"
    fi

    grep_cmd="grep -E 'text|json'"
    preview_cmd="if file --mime {} | $grep_cmd > /dev/null; then $file_cmd {}; else echo ' ---'; fi"

    # fzf
    file=$(printf "%s\n" "$file_list" \
        | fzf -e +s \
              --prompt="Enter file pattern: " \
              --info=inline \
              --preview="$preview_cmd" \
              --preview-window=right:60%
    )

    # Otwórz plik w edytorze
    if [[ -n "$file" ]]; then
        "$EDITOR" "$file"
    fi
}



cdd() {
    local dir start_dir fd_dirs
    
    # 1. Ustal katalog startowy
    start_dir="$(realpath -m "${1:-$HOME}")"

    # 2. Pobierz listę katalogów (bez .git)
    if command -v fd &>/dev/null; then
        fd_dirs=$(fd . "$start_dir" -u -t d -E .git)
    else
        fd_dirs=$(find "$start_dir" -type d -not -path "*/.git*")
    fi   
    
    # 3. Dołącz katalog startowy jako pierwszy
    dir=$(printf "%s\n%s" "$start_dir" "$fd_dirs" \
        | fzf -e \
              --prompt="Enter directory template [$start_dir]: " \
              --preview='tree -L 1 -F --dirsfirst {}')


    if [[ -n "$dir" ]]; then
        cd "$dir" || exit 1
        clear
    
        if [[ "$dir" != "$HOME" ]]; then
            ls -a
        fi
    else
        echo -e "\e[No directory selected.\e[0m"
    fi
  }

# ---

complete -o default -o filenames mc
complete -F default -o dirnames cdd
