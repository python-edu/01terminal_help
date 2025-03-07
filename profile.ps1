# Użytkownik edytuje tę linię i wpisuje swój ulubiony edytor
$env:EDITOR = "nvim"  # Zmień na: "micro", "vim", "code", itp.

# Alias dla edytora
Set-Alias mc $env:EDITOR


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





# Funkcja cdd - wyszukiwanie katalogów i przechodzenie do wybranego
function cdd {
    $dir = Get-ChildItem -Path $HOME -Directory -Recurse -Force | ForEach-Object { $_.FullName } | 
        fzf --exact --prompt="Enter directory template: " `
            --preview='dir {}'

    if ($dir) {
        cls
        Set-Location -Path $dir
        Get-ChildItem -Force
    }
}
