# 🔹 Użytkownik edytuje tę linię i wpisuje swój ulubiony edytor
$env:EDITOR = "nvim"  # Zmień na: "micro", "vim", "code", itp.

# Alias dla edytora
Set-Alias mc $env:EDITOR


function mcc {
    $file = Get-ChildItem -Path $HOME -File -Recurse -Force -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName | 
        fzf --exact --prompt="Enter file pattern: " --info=inline `
            --preview="powershell -NoProfile -ExecutionPolicy Bypass -Command `
            \"`$file = '{}'; `
            if ((Get-Item `$file).Length -lt 1048576) { `
                try { `
                    `$content = Get-Content -Path `$file -Raw -ErrorAction Stop; `
                    if (`$content -match '\P{C}') { `$content } else { '--- [BINARY FILE] ---' } `
                } catch { '--- [CANNOT READ FILE] ---' } `
            } else { '--- [BINARY FILE] ---' }\""

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
