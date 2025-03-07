$env:EDITOR = "nvim"
if (-not $env:EDITOR) {
    $env:EDITOR = "micro"
}

Set-Alias mc $env:EDITOR


function mcc {
    $file = Get-ChildItem -Path $HOME -File -Recurse -Force | ForEach-Object { $_.FullName } | fzf --exact --prompt="Enter file pattern: " --info=inline `
        --preview='if (Test-Path {} -PathType Leaf) { Get-Content -Path {} -ErrorAction SilentlyContinue } else { " ---" }'

    if ($file) {
        & $global:EDITOR $file
    }
}

function cdd {
    $dir = Get-ChildItem -Path $HOME -Directory -Recurse -Force | ForEach-Object { $_.FullName } | fzf --exact --prompt="Enter directory template: " `
        --preview='tree -L 1 -F --dirsfirst {}'

    if ($dir) {
        Set-Location -Path $dir
        Get-ChildItem -Force
    }
}

