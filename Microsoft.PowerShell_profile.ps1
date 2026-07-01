Remove-PSReadLineKeyHandler -Chord 'Ctrl+v'

function sessionizer {
    $dir = Get-ChildItem -Path "C:\DEV-Gabriel","$HOME\desneaDev" -Directory -Depth 3 -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty FullName | fzf
    if (-not $dir) { return }
    
    cd $dir
}

function zellisesh {
    $dir = Get-ChildItem -Path "C:\DEV-Gabriel","$HOME\desneaDev" -Directory -Depth 3 -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty FullName | fzf
    if (-not $dir) { return }

    $sessionName = Split-Path $dir -Leaf
    zellij attach --create $sessionName options --default-cwd $dir
}

function fuzzycd {
    $dir = Get-ChildItem -Path "." -Directory -Depth 3 -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty FullName | fzf
    if (-not $dir) { return }
    
    cd $dir
}

Set-Alias cdd sessionizer
Set-Alias zdd zellisesh
Set-Alias zd fuzzycd
