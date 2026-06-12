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

function Read-Manifest([string]$Path) {
    if (Test-Path $Path) {
        return Get-Content $Path -Raw | ConvertFrom-Json
    }
    # First release: the canonical manifest does not exist yet.
    [pscustomobject]@{
        appName     = $script:AppName
        description = $script:AppDescription
        items       = @()
    }
}

function Test-BuildInManifest($Manifest, [int]$Build) {
    foreach ($item in $Manifest.items) {
        if ([int]$item.shortVersion -eq $Build) { return $true }
    }
    return $false
}

function Add-ManifestItem($Manifest, [string]$DisplayVersion, [int]$Build,
        [string]$Date, [bool]$IsMandatory, [string]$Url, [string[]]$NoteLines) {
    $changes = @($NoteLines | ForEach-Object {
        [pscustomobject]@{ type = 'feat'; message = $_ }
    })
    $item = [pscustomobject]@{
        version      = $DisplayVersion
        shortVersion = $Build      # JSON number - plugin ItemModel wants int
        date         = $Date
        mandatory    = $IsMandatory
        platform     = 'windows'
        url          = $Url        # must keep trailing /
        changes      = $changes
    }
    $Manifest.items = @($Manifest.items) + @($item)
    $Manifest
}

function Write-Manifest($Manifest, [string]$Path) {
    $json = $Manifest | ConvertTo-Json -Depth 6
    Set-Content -Path $Path -Value $json -Encoding utf8NoBOM
}

# --- main (everything below is skipped when dot-sourced for testing) -------
if ($MyInvocation.InvocationName -eq '.') { return }

Set-Location $script:RepoRoot

# Preflight ------------------------------------------------------------------
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) { Fail 'flutter is not on PATH' }
if (-not (Get-Command dart -ErrorAction SilentlyContinue)) { Fail 'dart is not on PATH' }

if (git status --porcelain) { Fail 'working tree is not clean - commit or stash first' }
$branch = git rev-parse --abbrev-ref HEAD
if ($branch -ne 'master') { Fail "current branch is '$branch' - releases are cut from master" }

$constants = Get-Content (Join-Path $script:RepoRoot 'lib/src/constants.dart') -Raw
if (-not $constants.Contains($script:ProductionManifestUrl)) {
    Fail "appArchiveUrl in lib/src/constants.dart is not the production URL $($script:ProductionManifestUrl)"
}

$v = Get-PubspecVersion (Join-Path $script:RepoRoot 'pubspec.yaml')
$distDir = Join-Path $script:RepoRoot "dist\$($v.Build)"
if (Test-Path $distDir) {
    if (-not $Force) { Fail "$distDir already exists (use -Force to rebuild)" }
    Remove-Item -Recurse -Force $distDir
}

$manifest = Read-Manifest $script:ManifestPath
if (Test-BuildInManifest $manifest $v.Build) {
    Fail "build $($v.Build) is already published in $($script:ManifestPath)"
}

Write-Host "Releasing $($script:AppName) $($v.Display)+$($v.Build)" -ForegroundColor Green

# Build + package ------------------------------------------------------------
Invoke-Step 'flutter clean' { flutter clean }
Invoke-Step 'flutter pub get' { flutter pub get }
Invoke-Step 'flutter build windows --release' { flutter build windows --release }
Invoke-Step 'desktop_updater:release' { dart run desktop_updater:release windows }
Invoke-Step 'desktop_updater:archive' { dart run desktop_updater:archive windows }

$appFolder  = Join-Path $distDir "enigma_signal_meter-$($v.Display)+$($v.Build)-windows"
$updateTree = Join-Path $distDir "$($v.Display)+$($v.Build)-windows"
if (-not (Test-Path (Join-Path $appFolder 'enigma_signal_meter.exe'))) {
    Fail "expected app folder $appFolder is missing or incomplete"
}
if (-not (Test-Path (Join-Path $updateTree 'hashes.json'))) {
    Fail "expected update tree $updateTree is missing hashes.json"
}

# First-install zip (zip root is the app folder, so extraction is tidy) ------
$zipPath = Join-Path $distDir "enigma_signal_meter-$($v.Display)-windows.zip"
Write-Host '==> zip first-install download' -ForegroundColor Cyan
Compress-Archive -Path $appFolder -DestinationPath $zipPath -Force
