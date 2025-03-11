# This file contains the configuration for PowerShell:
#   - download the file to disk
#   - cp prfile.sc1 $PROFILE - copy the file to the default path $PROFILE
#   - edit the file and set the $env:EDITOR variable
#
# The script contains functions that help search files and directories on the disk in the user's home directory.
# The functions use additional programs that the user must install using e.g. the `scoop` manager. Additional programs:
#   - micro - text editor
#   - fd - disk search program (it is the input to fzf)
#   - fzf - general-purpose command-line fuzzy finder
#   - bat - displays the contents of a file in the terminal
# 
# Functions:
#   - mcc: searches for files, displays the contents of text files and opens the selected file for reading
#   - cdd: searches for directories, displays the contents of the selected directory and goes to the selected directory


# edit the line below - enter your editor
$env:EDITOR = "micro"  #  "micro", "vim", "code", ...

# Alias
Set-Alias mc $env:EDITOR


# searches for files, previews and opens the selected file for editing
function mcc {
    $file = fd . "$HOME" -u -t f --follow --exclude .git . |
            fzf --ansi --preview 'bat --color=always {} --style=numbers,changes'

    if ($file) {
        Write-Host "Opening: $file" -ForegroundColor Green
        & $env:EDITOR $file
    } else {
        Write-Host "No file selected." -ForegroundColor Yellow
    }
}



# searches for directories, previews and navigates to the selected folder
function cdd {
    $dirs = fd . "$HOME" -u -a -t d -I -E .git
    $dirs += $HOME  # Dodaj katalog domowy na końcu listy

    $dir = $dirs | fzf --exact --prompt="Enter directory template: " --preview='dir {}'

    if ($dir) {
        cls
        Set-Location -Path $dir
        Get-ChildItem -Force
    }
}

