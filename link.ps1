# Windows counterpart of `stow .` - run from an elevated pwsh (symlinks need admin)
$d = $PSScriptRoot
$links = @{
    "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" = "$d\Microsoft.PowerShell_profile.ps1"
    "$HOME\AppData\Roaming\zellij\config\config.kdl"              = "$d\.config\zellij\config.kdl"
    "$HOME\AppData\Local\nvim"                                    = "$d\.config\nvim"
}
foreach ($l in $links.GetEnumerator()) {
    $i = Get-Item $l.Key -Force -ErrorAction SilentlyContinue
    if ($i -and $i.LinkType -eq 'SymbolicLink') { continue }
    if ($i) { Move-Item $l.Key "$($l.Key).bak" -Force }
    New-Item -ItemType SymbolicLink -Path $l.Key -Target $l.Value | Out-Null
    "linked $($l.Key)"
}
