Remove-PSReadLineKeyHandler -Chord 'Ctrl+v'

function z {
    zellij @args
}

function zellisesh {
    # sessions (newest first) then dirs; git dirs are named <dir>@<branch>
    $sessions = @(zellij ls -n -r 2>$null | ForEach-Object { ($_ -split ' ')[0] })
    $dirs = @{}
    Get-ChildItem -Path "C:\DEV-Gabriel","$HOME\desneaDev" -Directory -Depth 3 -ErrorAction SilentlyContinue | ForEach-Object {
        $name = $_.Name
        if (Test-Path "$($_.FullName)\.git") {
            $b = git -C $_.FullName branch --show-current 2>$null
            if ($b) { $name = "$name@$($b -replace '/','-')" }
        }
        $dirs[$name] = $_.FullName
    }
    $lines = @($sessions | ForEach-Object { "$_`t$($dirs[$_])" }) +
             @($dirs.Keys | Where-Object { $_ -notin $sessions } | Sort-Object | ForEach-Object { "$_`t$($dirs[$_])" })
    $pick = $lines | fzf --delimiter "`t" --with-nth 1
    if (-not $pick) { return }

    $name, $dir = $pick -split "`t"
    if (-not $dir) { zellij attach $name; return }   # session whose branch/dir no longer matches
    zellij attach --create $name options --default-cwd $dir --default-layout "$HOME\dotfiles\.config\zellij\layouts\dev.kdl"
}

function fuzzycd {
    param([string]$from = ".")

    if ($from -match '^[A-Za-z]:$') { $from += '\' }
    $root = Resolve-Path -Path $from -ErrorAction SilentlyContinue
    if (-not $root) { Write-Error "fcd: path not found: $from"; return }

    $dir = Get-ChildItem -Path $root -Directory -Depth 3 -ErrorAction SilentlyContinue |
        ForEach-Object { $_.FullName } | fzf
    if (-not $dir) { return }

    Set-Location $dir
}

function prompt {
    $p = $executionContext.SessionState.Path.CurrentLocation

    if ($p.Provider.Name -eq "FileSystem") {
        [System.Environment]::CurrentDirectory = $p.ProviderPath
    }
    "PS $p$('>' * ($nestedPromptLevel + 1)) "
}

Set-Alias fz  zellisesh
Set-Alias zd zellisesh
Set-Alias fcd fuzzycd
