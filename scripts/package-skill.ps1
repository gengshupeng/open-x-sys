[CmdletBinding()]
param([switch]$Check)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$repositoryRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$outputRoot = Join-Path $repositoryRoot 'dist'
$version = [IO.File]::ReadAllText((Join-Path $repositoryRoot 'VERSION')).Trim()
$packageRecords = @()
if (-not $Check) { New-Item -ItemType Directory -Path $outputRoot -Force | Out-Null }

function Get-PackageFiles {
    param([string]$Edition)
    $skillRoot = Join-Path $repositoryRoot ('skills/' + $Edition)
    foreach ($file in (Get-ChildItem -LiteralPath $skillRoot -Recurse -File)) {
        [pscustomobject]@{
            Source = $file.FullName
            Entry = $Edition + '/' + $file.FullName.Substring($skillRoot.Length + 1).Replace('\', '/')
        }
    }
    [pscustomobject]@{ Source = (Join-Path $repositoryRoot 'LICENSE'); Entry = $Edition + '/LICENSE' }
    [pscustomobject]@{ Source = (Join-Path $repositoryRoot 'VERSION'); Entry = $Edition + '/VERSION' }
}

foreach ($edition in @('open-x-sys', 'open-x-sys.zh-CN')) {
    $packagePath = Join-Path $outputRoot ($edition + '.zip')
    $files = @(Get-PackageFiles -Edition $edition | Sort-Object Entry)
    if (-not $Check) {
        $stream = [IO.File]::Open($packagePath, [IO.FileMode]::Create)
        $archive = New-Object IO.Compression.ZipArchive($stream, [IO.Compression.ZipArchiveMode]::Create)
        try {
            foreach ($file in $files) {
                $entry = $archive.CreateEntry($file.Entry, [IO.Compression.CompressionLevel]::Optimal)
                $entry.LastWriteTime = [DateTimeOffset]::new(2000, 1, 1, 0, 0, 0, [TimeSpan]::Zero)
                $inputStream = [IO.File]::OpenRead($file.Source)
                $entryStream = $entry.Open()
                try { $inputStream.CopyTo($entryStream) }
                finally { $entryStream.Dispose(); $inputStream.Dispose() }
            }
        }
        finally { $archive.Dispose(); $stream.Dispose() }
    }
    $archive = [IO.Compression.ZipFile]::OpenRead($packagePath)
    try {
        $entries = @{}
        foreach ($entry in $archive.Entries) {
            if ($entries.ContainsKey($entry.FullName)) { throw ('Duplicate package entry: ' + $entry.FullName) }
            $entries[$entry.FullName] = $entry
        }
        if ($entries.Count -ne $files.Count) { throw ('Unexpected package file count: ' + $edition) }
        foreach ($file in $files) {
            if (-not $entries.ContainsKey($file.Entry)) { throw ('Missing package file: ' + $file.Entry) }
            $entryStream = $entries[$file.Entry].Open()
            $sha = [Security.Cryptography.SHA256]::Create()
            try { $entryHash = [BitConverter]::ToString($sha.ComputeHash($entryStream)).Replace('-', '') }
            finally { $sha.Dispose(); $entryStream.Dispose() }
            if ($entryHash -ne (Get-FileHash -LiteralPath $file.Source -Algorithm SHA256).Hash) {
                throw ('Package content differs from source: ' + $file.Entry)
            }
        }
    }
    finally { $archive.Dispose() }
    Write-Output ($edition + ': ' + $files.Count + ' files checked; SHA-256 ' + (Get-FileHash -LiteralPath $packagePath -Algorithm SHA256).Hash)
    $packageRecords += [ordered]@{
        file = ($edition + '.zip')
        language = $(if ($edition -eq 'open-x-sys') { 'en' } else { 'zh-CN' })
        version = $version
        files = $files.Count
        sha256 = (Get-FileHash -LiteralPath $packagePath -Algorithm SHA256).Hash.ToLowerInvariant()
    }
}

$metadataPath = Join-Path $outputRoot 'release.json'
$checksumPath = Join-Path $outputRoot 'SHA256SUMS'
$newLine = [string][char]10
if ($Check) {
    $metadata = [IO.File]::ReadAllText($metadataPath) | ConvertFrom-Json
    if ($metadata.version -ne $version -or @($metadata.packages).Count -ne $packageRecords.Count) { throw 'Release metadata does not match VERSION.' }
    for ($i = 0; $i -lt $packageRecords.Count; $i++) {
        foreach ($key in @('file','language','version','files','sha256')) {
            if ($metadata.packages[$i].$key -ne $packageRecords[$i][$key]) { throw ('Release metadata mismatch: ' + $key) }
        }
    }
    $expected = (@($packageRecords | ForEach-Object { $_.sha256 + '  ' + $_.file }) -join $newLine) + $newLine
    if ([IO.File]::ReadAllText($checksumPath).Replace([string][char]13, '') -ne $expected) { throw 'SHA256SUMS does not match the packages.' }
} else {
    $metadata = [ordered]@{ version = $version; label = ($version.Split('-')[0] + ' Alpha Preview'); packages = $packageRecords }
    $utf8 = [Text.UTF8Encoding]::new($false)
    [IO.File]::WriteAllText($metadataPath, ((ConvertTo-Json -InputObject $metadata -Depth 5).Replace([string][char]13, '') + $newLine), $utf8)
    [IO.File]::WriteAllText($checksumPath, ((@($packageRecords | ForEach-Object { $_.sha256 + '  ' + $_.file }) -join $newLine) + $newLine), $utf8)
}
