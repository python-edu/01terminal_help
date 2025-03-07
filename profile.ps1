$env:EDITOR = "nvim"

if (-not $env:EDITOR) {
    $env:EDITOR = "micro"
}

Set-Alias mc $env:EDITOR


# Funkcja mcc - wyszukiwanie plików i otwieranie w edytorze
function mcc {
    $file = Get-ChildItem -Path $HOME -File -Recurse -Force | ForEach-Object { $_.FullName } | 
        fzf --exact --prompt="Enter file pattern: " --info=inline `
            --preview='if (Test-Path {} -PathType Leaf) { Get-Content -Path {} -ErrorAction SilentlyContinue | Out-String } else { " ---" }'

    if ($file) {
        & $env:EDITOR $file
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
