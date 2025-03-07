# edit the line below - enter your editor
$env:EDITOR = "nvim"  #  "micro", "vim", "code", ...

# Alias
Set-Alias mc $env:EDITOR


# searches for files, previews and opens the selected file for editing
function mcc {
    $file = fd --type file --follow --exclude .git . |
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
    $dir = Get-ChildItem -Path $HOME -Directory -Recurse -Force | ForEach-Object { $_.FullName } | 
    $dirs = $dirs + $HOME  # Katalog domowy zawsze na końcu listy
    $dir = $dirs
    fzf --exact --prompt="Enter directory template: " --preview='dir {}'

    if ($dir) {
        cls
        Set-Location -Path $dir
        Get-ChildItem -Force
    }
}
