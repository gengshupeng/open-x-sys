[CmdletBinding()]
param()
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
$root=Split-Path -Parent $PSScriptRoot
$fixture=Join-Path ([IO.Path]::GetTempPath()) ('openxsys-package-'+[Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $fixture|Out-Null
$fixtureRoot=(Resolve-Path -LiteralPath $fixture).Path
function Assert-Target([string]$Path){
 $resolved=[IO.Path]::GetFullPath($Path)
 if(-not$resolved.StartsWith($fixtureRoot+[IO.Path]::DirectorySeparatorChar,[StringComparison]::OrdinalIgnoreCase)-or[IO.Path]::GetFileName($resolved)-ne'open-x-sys'){throw 'Package test target is outside the fixture.'}
}
try{
 $personal=Join-Path $fixtureRoot '.openxsys'
 New-Item -ItemType Directory -Path $personal|Out-Null
 [IO.File]::WriteAllText((Join-Path $personal 'SYSTEM.md'),'Keep this personal system.')
 $version=[IO.File]::ReadAllText((Join-Path $root 'VERSION')).Trim()
 foreach($edition in @('open-x-sys','open-x-sys.zh-CN')){
  $unpacked=Join-Path $fixtureRoot ($edition+'-unpacked')
  [IO.Compression.ZipFile]::ExtractToDirectory((Join-Path $root ('dist/'+$edition+'.zip')),$unpacked)
  $source=Join-Path $unpacked $edition
  $directory=Join-Path $fixtureRoot ($edition+'-installed')
  New-Item -ItemType Directory -Path $directory|Out-Null
  $target=Join-Path $directory 'open-x-sys'
  Assert-Target $target
  Copy-Item -LiteralPath $source -Destination $target -Recurse
  foreach($file in @('SKILL.md','VERSION','LICENSE','methods/2-explain/first_principles.md','display/signature.md')){
   if(-not(Test-Path -LiteralPath (Join-Path $target $file))){throw ('Incomplete package import: '+$file)}
  }
  if([IO.File]::ReadAllText((Join-Path $target 'VERSION')).Trim()-ne$version){throw 'Imported package version is stale.'}
  [IO.File]::WriteAllText((Join-Path $target 'SKILL.md'),'Old installed copy.')
  Assert-Target $target
  Remove-Item -LiteralPath $target -Recurse -Force
  Copy-Item -LiteralPath $source -Destination $target -Recurse
  foreach($file in (Get-ChildItem -LiteralPath $source -Recurse -File)){
   $relative=$file.FullName.Substring($source.Length+1)
   if((Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash-ne(Get-FileHash -LiteralPath (Join-Path $target $relative) -Algorithm SHA256).Hash){throw ('Imported file differs: '+$relative)}
  }
  Assert-Target $target
  Remove-Item -LiteralPath $target -Recurse -Force
  if(Test-Path -LiteralPath $target){throw 'Uninstall left package files behind.'}
  if([IO.File]::ReadAllText((Join-Path $personal 'SYSTEM.md'))-ne'Keep this personal system.'){throw 'Personal system changed.'}
  Write-Output ($edition+': ZIP folder import, replacement, file hashes and removal passed; personal system preserved.')
 }
}finally{
 $temporaryRoot=[IO.Path]::GetFullPath([IO.Path]::GetTempPath()).TrimEnd('\','/')+[IO.Path]::DirectorySeparatorChar
 $resolved=(Resolve-Path -LiteralPath $fixtureRoot).Path
 if(-not$resolved.StartsWith($temporaryRoot,[StringComparison]::OrdinalIgnoreCase)-or[IO.Path]::GetFileName($resolved)-notmatch'^openxsys-package-[a-f0-9]{32}$'){throw 'Invalid fixture cleanup target.'}
 Remove-Item -LiteralPath $resolved -Recurse -Force
}
