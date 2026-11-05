[CmdletBinding()]
param([switch]$Quiet)
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$python = Join-Path $root 'runtime/python/python.exe'
$server = Join-Path $root 'app/hermes-webui/server.py'
$errors = @()
if (-not (Test-Path -LiteralPath $python -PathType Leaf)) { $errors += 'Portable Python is missing: runtime/python/python.exe' }
if (-not (Test-Path -LiteralPath $server -PathType Leaf)) { $errors += 'Hermes WebUI is missing: app/hermes-webui/server.py' }
if ($errors.Count -gt 0) {
  foreach ($errorMessage in $errors) { Write-Host "[Ayatsumira] $errorMessage" }
  exit 2
}
$version = & $python -c 'import sys; print("%d.%d.%d" % sys.version_info[:3])'
if ($LASTEXITCODE -ne 0 -or $version -notmatch '^\d+\.\d+\.\d+$') { throw 'Portable Python executable failed validation' }
$parts = $version -split '\.'
if ([int]$parts[0] -ne 3 -or [int]$parts[1] -lt 11) { throw "Python 3.11+ required, found $version" }
$deps = & $python -c 'import yaml, cryptography; print("dependencies ok")' 2>&1
if ($LASTEXITCODE -ne 0) { throw "WebUI Python dependencies are missing. Install in the isolated runtime; details: $deps" }
if (-not $Quiet) { Write-Host "[Ayatsumira] Python $version; WebUI files and core dependencies found." }
exit 0
