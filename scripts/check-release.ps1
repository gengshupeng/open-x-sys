[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0
$root = Split-Path -Parent $PSScriptRoot
$version = [IO.File]::ReadAllText((Join-Path $root 'VERSION')).Trim()
if ($version -notmatch '^\d+\.\d+\.\d+-alpha\.\d+$') { throw 'VERSION must identify the Alpha Preview.' }
$files = @(Get-ChildItem -LiteralPath $root -Recurse -Force -File | Where-Object {
    $relative = $_.FullName.Substring($root.Length + 1).Replace('\','/')
    $relative -notmatch '^\.git/|^_site/|^\.openxsys-exporting$'
})
$linkCount = 0
$englishCount = 0
foreach ($file in $files) {
    $relative = $file.FullName.Substring($root.Length + 1).Replace('\','/')
    if ($relative -match '^docs/(archive|next)/|^docs/1\.0-handoff|^release/|^evals/acceptance/|^evals/reviews/(?!README)|^\.claude/|^\.openxsys/') { throw ('Internal material in public tree: ' + $relative) }
    if ($file.Extension -notin @('.md','.html','.json','.ps1','.sh','.css','.svg','.yml','.yaml') -and $file.Name -notin @('VERSION','LICENSE','SHA256SUMS','.gitignore','.gitattributes')) { continue }
    $body = [IO.File]::ReadAllText($file.FullName)
    if ($body.Contains([string][char]0xFFFD)) { throw ('Invalid UTF-8 text: ' + $relative) }
    if ($body -match '(?i)(?:[A-Z]:\\Users\\[^\s]+|file:/{3}[A-Z]:/|D:\\open-x-sys\\)') { throw ('Machine-local reference: ' + $relative) }
    if ($file.Extension -eq '.md' -and $relative -notmatch '(^|/)open-x-sys\.zh-CN/|\.zh-CN\.md$') {
        $englishCount++
        $originalMultilingualExamples = @('skills/open-x-sys/SKILL.md','skills/open-x-sys/styles/optional.md','skills/open-x-sys/routes/masters/musk_algorithm.md','skills/open-x-sys/methods/7-improve/review.md')
        if ($body -match '[\u4e00-\u9fff]' -and $relative -notin $originalMultilingualExamples) { throw ('Chinese text in an English document: ' + $relative) }
    }
    if ($file.Extension -notin @('.md','.html','.svg')) { continue }
    $linkBody = [regex]::Replace($body,'(?is)<script\b[^>]*>.*?</script>','')
    $references = @([regex]::Matches($linkBody,'\]\((?<url>[^)\s]+)(?:\s+"[^"]*")?\)'))
    $references += @([regex]::Matches($linkBody,'(?:src|srcset|href)="(?<url>[^"]+)"'))
    foreach ($reference in $references) {
        $url = $reference.Groups['url'].Value
        if ($url -match '^(?:https?:|mailto:|data:|javascript:)') { continue }
        $parts = $url.Split(@([char]'#'),2)
        $pathPart = [Uri]::UnescapeDataString(($parts[0] -split '\?',2)[0])
        $target = if ($pathPart) { [IO.Path]::GetFullPath((Join-Path $file.DirectoryName $pathPart)) } else { $file.FullName }
        if (-not $target.StartsWith($root + [IO.Path]::DirectorySeparatorChar,[StringComparison]::OrdinalIgnoreCase)) { throw ('Link outside public source: ' + $relative + ' -> ' + $url) }
        if (-not (Test-Path -LiteralPath $target)) { throw ('Missing link: ' + $relative + ' -> ' + $url) }
        if ($parts.Length -eq 2 -and $parts[1]) {
            $anchor = [Uri]::UnescapeDataString($parts[1])
            $targetBody = [IO.File]::ReadAllText($target)
            $found = $targetBody.Contains('id="' + $anchor + '"') -or $targetBody.Contains("id='" + $anchor + "'")
            if (-not $found) {
                foreach ($heading in [regex]::Matches($targetBody,'(?m)^#{1,6}\s+(.+)$')) {
                    $slug = ($heading.Groups[1].Value.Trim().ToLowerInvariant() -replace '[^\p{L}\p{N}\p{M}\s_-]','') -replace '\s','-'
                    if ($slug -eq $anchor) { $found = $true; break }
                }
            }
            if (-not $found) { throw ('Missing anchor: ' + $relative + ' -> ' + $url) }
        }
        $linkCount++
    }
}
foreach ($edition in @('open-x-sys','open-x-sys.zh-CN')) {
    $skill = Join-Path $root ('skills/' + $edition)
    $entry = [IO.File]::ReadAllText((Join-Path $skill 'SKILL.md'))
    if ($entry -notmatch ('version:\s*"' + [regex]::Escape($version) + '"')) { throw ('Skill version mismatch: ' + $edition) }
    $lock = [IO.File]::ReadAllText((Join-Path $skill 'deps/openxsys.lock.json')) | ConvertFrom-Json
    if ($lock.openxsys -ne $version) { throw ('Lock version mismatch: ' + $edition) }
    $shell = [IO.File]::ReadAllText((Join-Path $skill 'deps/install.sh'))
    if (-not $shell.Contains('"openxsys": "' + $version + '"')) { throw ('Shell record version mismatch: ' + $edition) }
}
foreach ($readme in @('README.md','README.zh-CN.md')) {
    $body = [IO.File]::ReadAllText((Join-Path $root $readme))
    if (-not $body.Contains($version)) { throw ('README version mismatch: ' + $readme) }
}
& (Join-Path $PSScriptRoot 'check-loading.ps1')
& (Join-Path $PSScriptRoot 'package-skill.ps1') -Check
Write-Output ('Public release checks passed: ' + $version + '; ' + $files.Count + ' files; ' + $linkCount + ' local links; ' + $englishCount + ' English documents.')
