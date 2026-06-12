#Requires -Version 7
<#
.SYNOPSIS
Builds, packages and stages a Windows release of Enigma Signal Meter.

.DESCRIPTION
Automates the release ritual from
docs/superpowers/specs/2026-06-12-windows-first-release-design.md:
preflight guards -> cold release build -> desktop_updater release/archive
-> first-install zip -> manifest append (tool/app-archive.json) -> upload
bundle under dist\<build>\upload with printed upload instructions.

Run from anywhere inside the repo:
  pwsh -NoProfile -File tool\release.ps1 -Notes "Short release note"
#>
[CmdletBinding()]
param(
    # Release-note lines; each becomes one changes[] entry in the manifest.
    [string[]]$Notes = @(),
    # Marks the release mandatory (the update dialog loses "Later").
    [switch]$Mandatory,
    # Overwrite an existing dist\<build> output.
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$script:RepoRoot = Split-Path $PSScriptRoot -Parent
$script:ProductionManifestUrl = 'https://www.krkadoni.com/signalmeter/app-archive.json'
$script:BaseUrl = 'https://www.krkadoni.com/signalmeter'
$script:AppName = 'Enigma Signal Meter'
$script:AppDescription = 'Enigma Signal Meter desktop updates'
$script:ManifestPath = Join-Path $PSScriptRoot 'app-archive.json'

function Fail([string]$Message) {
    Write-Host "RELEASE ABORTED: $Message" -ForegroundColor Red
    exit 1
}

# Runs a native command and aborts on non-zero exit code. Only for native
# executables (flutter/dart/git) - cmdlets do not set $LASTEXITCODE.
function Invoke-Step([string]$Name, [scriptblock]$Command) {
    Write-Host "==> $Name" -ForegroundColor Cyan
    & $Command
    if ($LASTEXITCODE -ne 0) { Fail "step '$Name' failed with exit code $LASTEXITCODE" }
}

function Get-PubspecVersion([string]$PubspecPath) {
    if (-not (Test-Path $PubspecPath)) { Fail "$PubspecPath not found" }
    $line = Get-Content $PubspecPath |
        Where-Object { $_ -match '^version:' } |
        Select-Object -First 1
    if (-not $line) { Fail "no 'version:' line in $PubspecPath" }
    if ($line -notmatch '^version:\s*(\d+\.\d+\.\d+)\+(\d+)\s*$') {
        Fail "version line '$line' is not in <major.minor.patch>+<build> form"
    }
    [pscustomobject]@{ Display = $Matches[1]; Build = [int]$Matches[2] }
}

# --- main (everything below is skipped when dot-sourced for testing) -------
if ($MyInvocation.InvocationName -eq '.') { return }
