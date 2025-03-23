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


# Function: mcc
# searches for files, previews and opens the selected file for editing
function mcc {
    param (
        [string]$StartDir
    )

    if (-not $StartDir) {
        $StartDir = $HOME
    } else {
        $StartDir = $StartDir.TrimEnd('\','/')
    }

    $file = fd . "$HOME" -u -t f --follow --exclude .git . |
            fzf --ansi --preview 'bat --color=always {} --style=numbers,changes'

    if ($file) {
        Write-Host "Opening: $file" -ForegroundColor Green
        & $env:EDITOR $file
    } else {
        Write-Host "No file selected." -ForegroundColor Yellow
    }
}


# Function: cdd
# Searches for directories and navigates to the selected one
function cdd {
    param (
        [string]$StartDir
    )

    if (-not $StartDir) {
        $StartDir = $HOME
    } else {
        $StartDir = $StartDir.TrimEnd('\','/')
    }

    echo "wejscie: $StartDir"

    $dirs = @(
        (Convert-Path $StartDir)
        (fd "" "$StartDir" -t d -u -a -I --exclude .git)
    )

    $dir = $dirs | fzf --exact --prompt="Enter directory template:" --preview 'dir {}'

    if ($dir) {
        Set-Location -Path $dir
        Clear-Host
        
        if ($dir.TrimEnd('\','/') -ne $HOME.TrimEnd('\','/')) {
            Get-ChildItem -Force
        }
    } else {
        Write-Host "No directory selected." -ForegroundColor Yellow
    }
}
