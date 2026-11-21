[CmdletBinding()]
param(
    [ValidateSet('', 'codex', 'claude-code', 'agents')]
    [string]$HostName = '',
    [string]$Destination = '',
    [ValidateSet('en-US', 'zh-CN')]
    [string]$Language = 'en-US',
    [switch]$Update,
    [switch]$Check,
    [switch]$Uninstall
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
[Console]::OutputEncoding = [Text.UTF8Encoding]::new($false)

$selectedActions = @(@($Update, $Check, $Uninstall) | Where-Object { $_ })
if ($selectedActions.Count -gt 1) { throw 'Choose only one of -Update, -Check, and -Uninstall.' }

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$version = [IO.File]::ReadAllText((Join-Path $repositoryRoot 'VERSION')).Trim()

if (-not $Destination) {
    $userHome = [Environment]::GetFolderPath('UserProfile')
    if (-not $HostName) {
        if (Test-Path -LiteralPath (Join-Path $userHome '.codex')) { $HostName = 'codex' }
        elseif (Test-Path -LiteralPath (Join-Path $userHome '.claude')) { $HostName = 'claude-code' }
        else { $HostName = 'agents' }
    }
    switch ($HostName) {
        'codex'       { $Destination = Join-Path (Join-Path $userHome '.codex') 'skills' }
        'claude-code' { $Destination = Join-Path (Join-Path $userHome '.claude') 'skills' }
        'agents'      { $Destination = Join-Path (Join-Path $userHome '.agents') 'skills' }
    }
}

if (-not [IO.Path]::IsPathRooted($Destination)) {
    $Destination = [IO.Path]::GetFullPath((Join-Path (Get-Location).Path $Destination))
} else {
    $Destination = [IO.Path]::GetFullPath($Destination)
}
$target = Join-Path $Destination 'open-x-sys'

function Get-InstalledInfo([string]$SkillPath) {
    $entry = Join-Path $SkillPath 'SKILL.md'
    if (-not (Test-Path -LiteralPath $entry -PathType Leaf)) { return $null }
    $text = [IO.File]::ReadAllText($entry)
    $versionMatch = [regex]::Match($text, '(?m)^  version: "(?<value>[^"]+)"\s*$')
    $editionMatch = [regex]::Match($text, '(?m)^  edition: (?<value>[^\s]+)\s*$')
    [pscustomobject]@{
        Version = if ($versionMatch.Success) { $versionMatch.Groups['value'].Value } else { 'unknown' }
        Edition = if ($editionMatch.Success) { $editionMatch.Groups['value'].Value } else { 'unknown' }
    }
}

if ($Check) {
    $installed = Get-InstalledInfo $target
    if ($null -eq $installed) { Write-Output "Not installed: $target" }
    else {
        Write-Output "Installed: OpenXSys $($installed.Version) [$($installed.Edition)]"
        Write-Output "Location: $target"
    }
    exit 0
}

if ($Update -and -not $PSBoundParameters.ContainsKey('Language')) {
    $installed = Get-InstalledInfo $target
    if ($installed -and $installed.Edition -in @('en-US', 'zh-CN')) { $Language = $installed.Edition }
}

$sourceName = if ($Language -eq 'zh-CN') { 'open-x-sys.zh-CN' } else { 'open-x-sys' }
$source = Join-Path $repositoryRoot (Join-Path 'skills' $sourceName)
if (-not (Test-Path -LiteralPath (Join-Path $source 'SKILL.md') -PathType Leaf)) {
    throw "Release source not found: $source"
}

$stamp = [DateTime]::UtcNow.ToString('yyyyMMdd-HHmmss-fff') + '-' + [guid]::NewGuid().ToString('N').Substring(0, 8)

if ($Uninstall) {
    if (-not (Test-Path -LiteralPath $target)) { Write-Output "Not installed: $target"; exit 0 }
    $backup = "$target.removed-$stamp"
    Move-Item -LiteralPath $target -Destination $backup
    Write-Output 'OpenXSys was removed from the host.'
    Write-Output "Recoverable backup: $backup"
    Write-Output 'User-owned .openxsys systems, works, and data remain unchanged.'
    exit 0
}

$existing = Get-InstalledInfo $target
if ($existing -and -not $Update) {
    throw "Target already exists (version $($existing.Version), edition $($existing.Edition)): $target`nRun again with -Update."
}

New-Item -ItemType Directory -Path $Destination -Force | Out-Null
$staging = Join-Path $Destination "open-x-sys.installing-$stamp-$PID"
if (Test-Path -LiteralPath $staging) { throw "Staging path already exists: $staging" }

$backup = $null
try {
    Copy-Item -LiteralPath $source -Destination $staging -Recurse
    $staged = Get-InstalledInfo $staging
    if ($null -eq $staged -or $staged.Version -ne $version -or $staged.Edition -ne $Language) {
        throw "Staged Skill identity mismatch: expected $version [$Language]."
    }
    if (Test-Path -LiteralPath $target) {
        $backup = "$target.backup-$stamp"
        Move-Item -LiteralPath $target -Destination $backup
    }
    Move-Item -LiteralPath $staging -Destination $target
} catch {
    if (Test-Path -LiteralPath $staging) { [IO.Directory]::Delete($staging, $true) }
    if ($backup -and (Test-Path -LiteralPath $backup) -and -not (Test-Path -LiteralPath $target)) {
        Move-Item -LiteralPath $backup -Destination $target
    }
    throw
}

$installed = Get-InstalledInfo $target
if ($null -eq $installed -or $installed.Version -ne $version -or $installed.Edition -ne $Language) {
    throw "Installed Skill identity mismatch: expected $version [$Language]."
}

Write-Output "OpenXSys $version [$Language] installed."
Write-Output "Location: $target"
if ($backup) { Write-Output "Previous version backup: $backup" }
if ($Language -eq 'zh-CN') { Write-Output 'OpenXSys is ready. You can now open a system in Chinese.' }
else { Write-Output 'Now say: Open a system for ...' }
