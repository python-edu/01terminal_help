# 🔹 Użytkownik edytuje tę linię i wpisuje swój ulubiony edytor
$env:EDITOR = "nvim"  # Zmień na: "micro", "vim", "code", itp.

# Alias dla edytora
Set-Alias mc $env:EDITOR





# Funkcja mcc - wyszukiwanie plików i otwieranie w edytorze
function mcc {
    $file = Get-ChildItem -Path $HOME -File -Recurse -Force -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty FullName |
        fzf --exact --prompt="Enter file pattern: " --info=inline `
            --preview="powershell -NoProfile -ExecutionPolicy Bypass -Command {
                param([string]`$f) 
                if (Test-Path `$f -PathType Leaf) { 
                    `$size = (Get-Item `$f).Length
                    if (`$size -lt 1048576) {
                        try {
                            `$content = Get-Content -Path `$f -Raw -ErrorAction Stop
                            if (`$content -match '[\x00-\x08\x0E-\x1F\x7F]') {
                                Write-Output '--- [BINARY FILE] ---'
                            } else {
                                Write-Output `$content
                            }
                        } catch {
                            Write-Output '--- [CANNOT READ FILE] ---'
                        }
                    } else {
                        Write-Output '--- [BINARY FILE] ---'
                    }
                } else {
                    Write-Output '--- [FILE NOT FOUND] ---'
                }
            }" --preview-window=wrap --preview-label="Preview"

    if ($file -and ($file -ne "")) {
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
