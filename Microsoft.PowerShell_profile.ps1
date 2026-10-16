Remove-PSReadLineKeyHandler -Chord 'Ctrl+v'

function z {
    zellij @args
}

function zellisesh {
    # sessions (newest first) then dirs; label = last 3 path parts (+ @<branch> for git dirs)
    # session name = label with '/' -> '-'; fzf shows the label, fields are name<TAB>dir<TAB>label
    $sessions = @(zellij ls -n -r 2>$null | ForEach-Object { ($_ -split ' ')[0] })
    $dirs = @{}; $labels = @{}
    Get-ChildItem -Path "C:\DEV-Gabriel","$HOME\desneaDev" -Directory -Depth 3 -ErrorAction SilentlyContinue | ForEach-Object {
        $label = (($_.FullName -split '[\\/]') | Select-Object -Last 3) -join '/'
        if (Test-Path "$($_.FullName)\.git") {
            $b = git -C $_.FullName branch --show-current 2>$null
            if ($b) { $label = "$label@$($b -replace '/','-')" }
        }
        $name = $label -replace '/','-'
        $dirs[$name] = $_.FullName
        $labels[$name] = $label
    }
    $row = { param($n) $l = if ($labels[$n]) { $labels[$n] } else { $n }; "$n`t$($dirs[$n])`t$l" }
    $lines = @($sessions | ForEach-Object { & $row $_ }) +
             @($dirs.Keys | Where-Object { $_ -notin $sessions } | Sort-Object | ForEach-Object { & $row $_ })
    $pick = $lines | fzf --delimiter "`t" --with-nth 3
    if (-not $pick) { return }

    $name, $dir, $null = $pick -split "`t"
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
