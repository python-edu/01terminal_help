# Ustawienie edytora (domyślnie nano, jeśli nie ustawiono)
$global:EDITOR = $env:EDITOR
if (-not $global:EDITOR) {
    $global:EDITOR = "micro"
}

# Alias dla edytora
Set-Alias mc $global:EDITOR

# Funkcja mcc - wyszukiwanie plików i otwieranie w edytorze
function mcc {
    $file = fzf --exact --prompt="Enter file pattern: " --info=inline `
        --preview='if (Get-Item {} | Get-Content -ErrorAction SilentlyContinue) { Get-Content {} } else { " ---" }' `
        (Get-ChildItem -Path $HOME -File -Recurse -Force | ForEach-Object { $_.FullName })
    
    if ($file) {
        & $global:EDITOR $file
    }
}

# Funkcja cdd - wyszukiwanie katalogów i przechodzenie do wybranego
function cdd {
    $dir = fzf --exact --prompt="Enter directory template: " `
        --preview='tree -L 1 -F --dirsfirst {}' `
        (Get-ChildItem -Path $HOME -Directory -Recurse -Force | ForEach-Object { $_.FullName })
    
    if ($dir) {
        Set-Location -Path $dir
        Get-ChildItem -Force
    }
}

# Eksportowanie funkcji do użytku w terminalu
# Set-Variable -Name "mcc" -Value $function:mcc -Option AllScope
# Set-Variable -Name "cdd" -Value $function:cdd -Option AllScope
