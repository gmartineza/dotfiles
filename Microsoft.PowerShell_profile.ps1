Remove-PSReadLineKeyHandler -Chord 'Ctrl+v'

# function fuzzycdevd {
#     $dir = Get-ChildItem -Path "C:\DEV-Gabriel","$HOME\desneaDev" -Directory -Depth 3 -ErrorAction SilentlyContinue |
#         Select-Object -ExpandProperty FullName | fzf
#     if (-not $dir) { return }
#
#     cd $dir
# }

function zellisesh {
    $dir = Get-ChildItem -Path "C:\DEV-Gabriel","$HOME\desneaDev" -Directory -Depth 3 -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty FullName | fzf
    if (-not $dir) { return }

    $sessionName = Split-Path $dir -Leaf
    zellij attach --create $sessionName options --default-cwd $dir
}

function fuzzycd {
    param([string]$from = ".")
    
    $dir = Get-ChildItem -Path $from -Directory -Depth 3 -ErrorAction SilentlyContinue |
        ForEach-Object { $_.FullName } | fzf
    if (-not $dir) { return }
    
    Set-Location $dir
}

Set-Alias zdd zellisesh
Set-Alias cdd fuzzycd
