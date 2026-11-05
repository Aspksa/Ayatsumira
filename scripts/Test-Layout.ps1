$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$required = @('Start.bat','README.md','docs/INTEGRATION.md','docs/SECURITY.md','scripts/Import-HermesWebUI.ps1')
foreach ($file in $required) {
  if (-not (Test-Path -LiteralPath (Join-Path $root $file))) { throw "Missing $file" }
}
$importer = Get-Content -LiteralPath (Join-Path $root 'scripts/Import-HermesWebUI.ps1') -Raw
if (-not $importer.Contains('Commit verification failed')) { throw 'Importer lacks commit verification' }
if (-not $importer.Contains('Target already exists')) { throw 'Importer lacks overwrite guard' }
Write-Host 'Layout and importer static checks passed.'
