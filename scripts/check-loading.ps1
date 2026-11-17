[CmdletBinding()]
param([string]$RepositoryRoot,[switch]$SelfTest)
$ErrorActionPreference='Stop'
Set-StrictMode -Version 2.0
function Test-Resources([string]$Root) {
 $issues=New-Object 'System.Collections.Generic.List[string]'
 $editions=@('open-x-sys','open-x-sys.zh-CN')
 $paths=@{};$support=0
 foreach($edition in $editions){
  $skillRoot=Join-Path $Root ('skills/'+$edition)
  if(-not(Test-Path -LiteralPath (Join-Path $skillRoot 'SKILL.md'))){$issues.Add($edition+': missing SKILL.md');continue}
  $paths[$edition]=@(Get-ChildItem -LiteralPath $skillRoot -Recurse -File|ForEach-Object{$_.FullName.Substring($skillRoot.Length+1).Replace('\','/')}|Sort-Object)
  foreach($file in (Get-ChildItem -LiteralPath $skillRoot -Recurse -File -Filter '*.md')){
   if($file.Name-ne'SKILL.md'){$support++}
   $body=[IO.File]::ReadAllText($file.FullName)
   if($body.Contains([string][char]0xFFFD)){$issues.Add($edition+': invalid UTF-8 in '+$file.Name)}
   $resources=[regex]::Matches($body,'\x60(?<path>(?:methods|routes|engines|system|display|styles|patterns|kit|deps|playground)/[^\x60\r\n]+\.md)\x60')
   foreach($reference in $resources){
    $relative=$reference.Groups['path'].Value
    if($relative-match'[<>*]'){continue}
    $target=Join-Path $skillRoot $relative
    if(-not(Test-Path -LiteralPath $target)){
     if($relative-like'playground/*'){$target=Join-Path $Root $relative}
     if(-not(Test-Path -LiteralPath $target)){$issues.Add($edition+': missing resource '+$relative)}
    }
   }
   foreach($reference in [regex]::Matches($body,'\]\((?<path>[^)\s]+)(?:\s+"[^"]*")?\)')){
    $relative=$reference.Groups['path'].Value
    if($relative-match'^(https?:|mailto:|#)'){continue}
    $relative=($relative-split'[?#]',2)[0]
    if(-not(Test-Path -LiteralPath (Join-Path $file.DirectoryName $relative))){$issues.Add($edition+': broken link '+$relative)}
   }
  }
 }
 if($paths.Count-eq 2 -and ($paths[$editions[0]]-join'|')-ne($paths[$editions[1]]-join'|')){$issues.Add('Edition file structures differ.')}
 return [pscustomobject]@{Issues=$issues.ToArray();SupportingPages=$support}
}
function Test-Fixtures([string]$Root){
 $temporaryRoot=[IO.Path]::GetFullPath([IO.Path]::GetTempPath()).TrimEnd('\','/')
 $fixtureRoot=Join-Path $temporaryRoot ('openxsys-resources-'+[Guid]::NewGuid().ToString('N'))
 New-Item -ItemType Directory -Path $fixtureRoot|Out-Null
 try{
  foreach($case in @('valid','missing-entry','missing-resource','broken-link','edition-structure')){
   $caseRoot=Join-Path $fixtureRoot $case
   New-Item -ItemType Directory -Path $caseRoot|Out-Null
   Copy-Item -LiteralPath (Join-Path $Root 'skills') -Destination (Join-Path $caseRoot 'skills') -Recurse
   if(Test-Path -LiteralPath (Join-Path $Root 'playground')){Copy-Item -LiteralPath (Join-Path $Root 'playground') -Destination (Join-Path $caseRoot 'playground') -Recurse}
   $entry=Join-Path $caseRoot 'skills/open-x-sys/SKILL.md'
   switch($case){
    'missing-entry'{Remove-Item -LiteralPath $entry}
    'missing-resource'{[IO.File]::AppendAllText($entry,([char]10+[string][char]96+'engines/missing.md'+[char]96+[char]10))}
    'broken-link'{[IO.File]::AppendAllText($entry,([char]10+'[missing](missing.md)'+[char]10))}
    'edition-structure'{Remove-Item -LiteralPath (Join-Path $caseRoot 'skills/open-x-sys/styles/plain.md')}
   }
   $result=Test-Resources $caseRoot
   if($case-eq'valid' -and $result.Issues.Count){throw ('Valid fixture failed: '+($result.Issues-join'; '))}
   if($case-ne'valid' -and -not$result.Issues.Count){throw ('Invalid fixture accepted: '+$case)}
  }
  Write-Output 'Resource checker fixtures passed: 5.'
 }finally{
  $resolved=(Resolve-Path -LiteralPath $fixtureRoot).Path
  if(-not$resolved.StartsWith($temporaryRoot+[IO.Path]::DirectorySeparatorChar,[StringComparison]::OrdinalIgnoreCase)-or[IO.Path]::GetFileName($resolved)-notmatch'^openxsys-resources-[a-f0-9]{32}$'){throw 'Invalid fixture cleanup path.'}
  Remove-Item -LiteralPath $resolved -Recurse -Force
 }
}
if(-not$RepositoryRoot){$RepositoryRoot=Split-Path -Parent $PSScriptRoot}
$RepositoryRoot=(Resolve-Path -LiteralPath $RepositoryRoot).Path
$result=Test-Resources $RepositoryRoot
if($result.Issues.Count){$result.Issues|ForEach-Object{Write-Output $_};exit 1}
Write-Output ('Resource checks passed: 2 editions, '+$result.SupportingPages+' supporting pages. No runtime reading sequence is imposed.')
if($SelfTest){Test-Fixtures $RepositoryRoot}
