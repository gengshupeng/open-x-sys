[CmdletBinding()]
param([string]$OutputDir)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
if (-not $OutputDir) { $OutputDir = Join-Path $root '_site' }
$destinationRoot = [IO.Path]::GetFullPath($OutputDir).TrimEnd('\','/')
if ($destinationRoot -eq $root -or $destinationRoot -eq [IO.Path]::GetPathRoot($destinationRoot).TrimEnd('\','/')) { throw 'Choose a separate site output directory.' }
if (Test-Path -LiteralPath $destinationRoot) {
    if (@(Get-ChildItem -LiteralPath $destinationRoot -Force).Count -gt 0) { throw 'The site output directory must be empty.' }
}
New-Item -ItemType Directory -Path $destinationRoot -Force | Out-Null
foreach ($directory in @('site','gallery','assets','docs','dist')) {
    Copy-Item -LiteralPath (Join-Path $root $directory) -Destination (Join-Path $destinationRoot $directory) -Recurse
}
foreach ($file in @('index.html','README.md','README.zh-CN.md','CONTRIBUTING.md','CONTRIBUTING.zh-CN.md','CHANGELOG.md','CHANGELOG.zh-CN.md','VERSION','LICENSE')) {
    Copy-Item -LiteralPath (Join-Path $root $file) -Destination (Join-Path $destinationRoot $file)
}
# Include the complete public resources referenced by the documentation.
foreach ($directory in @('skills','playground','academy','practices','x-sys','evals','scripts')) {
    Copy-Item -LiteralPath (Join-Path $root $directory) -Destination (Join-Path $destinationRoot $directory) -Recurse
}
[IO.File]::WriteAllText((Join-Path $destinationRoot '.nojekyll'),'',[Text.UTF8Encoding]::new($false))
Write-Output ('Static website built at ' + $destinationRoot)
