Remove-PSReadLineKeyHandler -Chord 'Ctrl+v'

function z {
    zellij @args
}

function zellisesh {
    # pick git dir, then branch (non-current branches open in a worktree); session = last 3 path parts + '@' + branch, '/' -> '-'. Existing session is re-attached.
    $repos = Get-ChildItem -Path "C:\DEV-Gabriel","$HOME\desneaDev" -Directory -Depth 3 -ErrorAction SilentlyContinue |
        Where-Object { Test-Path "$($_.FullName)\.git" -PathType Container } | ForEach-Object FullName   # worktrees have a .git file: skip
    $dir = $repos | fzf --prompt 'repo> '
    if (-not $dir) { return }

    $sessions = @(zellij ls -n -r 2>$null | ForEach-Object { ($_ -split ' ')[0] })
    $cur = git -C $dir branch --show-current 2>$null
    $base = (($dir -split '[\\/]') | Select-Object -Last 3) -join '-'
    $sess = { param($b) "$base@$($b -replace '/','-')" }
    $branches = @(git -C $dir branch --format='%(refname:short)' 2>$null)
    $lines = @($cur) + @($branches | Where-Object { $_ -ne $cur }) | Where-Object { $_ } | ForEach-Object {
        $mark = if ((& $sess $_) -in $sessions) { '*' } else { ' ' }   # * = session exists
        "$_`t$mark $_"
    }
    $b = ($lines | fzf --delimiter "`t" --with-nth 2 --prompt 'branch> ') -split "`t" | Select-Object -First 1
    if (-not $b) { return }

    $name = & $sess $b
    if ($name -in $sessions) { zellij attach $name; return }
    if ($b -ne $cur) {
        # one worktree per branch, so the main dir is never switched
        $wt = git -C $dir worktree list --porcelain | ForEach-Object {
            if ($_ -like 'worktree *') { $p = $_.Substring(9) } elseif ($_ -eq "branch refs/heads/$b") { $p }
        } | Select-Object -First 1
        if (-not $wt) {
            $wt = Join-Path (Split-Path $dir) "$(Split-Path $dir -Leaf).wt\$($b -replace '/','-')"
            git -C $dir worktree add $wt $b; if ($LASTEXITCODE) { return }
        }
        $dir = $wt
    }
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

# Reload Path from the registry (keeps session-only entries) so new installs work without restarting. Bound to Alt r in zellij.
function reload-path {
    $reg = 'Machine','User' | ForEach-Object { [Environment]::GetEnvironmentVariable('Path', $_) -split ';' }
    $env:Path = (($reg + ($env:Path -split ';')) | Where-Object { $_ } | Select-Object -Unique) -join ';'
}

Set-Alias fz  zellisesh
Set-Alias zd zellisesh
Set-Alias fcd fuzzycd
