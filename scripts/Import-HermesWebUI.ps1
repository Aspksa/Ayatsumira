# Explicit, non-destructive upstream import. Requires Git and an audited full commit SHA.
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][ValidatePattern('^[a-fA-F0-9]{40}$')][string]$Commit,
  [string]$Repository = 'https://github.com/nesquena/hermes-webui.git'
)
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$target = Join-Path $root 'app/hermes-webui'
if (Test-Path -LiteralPath $target) { throw "Target already exists. Refusing to overwrite: $target" }
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Git executable not found. No changes made.' }
$parent = Split-Path -Parent $target
New-Item -ItemType Directory -Path $parent -Force | Out-Null
$temporary = Join-Path $parent ('hermes-webui-import-' + [guid]::NewGuid().ToString('N'))
try {
  & git clone --no-checkout -- $Repository $temporary
  if ($LASTEXITCODE -ne 0) { throw 'git clone failed' }
  & git -C $temporary checkout --detach $Commit
  if ($LASTEXITCODE -ne 0) { throw 'Commit checkout failed' }
  $actual = (& git -C $temporary rev-parse HEAD).Trim()
  if ($LASTEXITCODE -ne 0 -or $actual -ne $Commit.ToLowerInvariant()) { throw 'Commit verification failed' }
  foreach ($required in @('LICENSE','server.py','requirements.txt')) {
    if (-not (Test-Path -LiteralPath (Join-Path $temporary $required))) { throw "Missing upstream file: $required" }
  }
  $license = Get-Content -LiteralPath (Join-Path $temporary 'LICENSE') -Raw
  if (-not $license.Contains('MIT License')) { throw 'Unexpected upstream license; review manually' }
  if (Test-Path -LiteralPath $target) { throw 'Destination appeared during import; refusing overwrite' }
  Move-Item -LiteralPath $temporary -Destination $target
  Write-Host "Imported verified Hermes WebUI commit $actual to $target"
  Write-Host 'Next: manually validate Python dependencies, Hermes Agent compatibility and Windows runtime.'
} finally {
  if (Test-Path -LiteralPath $temporary) { Remove-Item -LiteralPath $temporary -Recurse -Force }
}
